package core

import (
	"encoding/json"
	"fmt"
	"hash/fnv"
	"io"
	"log"
	"net/rpc"
	"os"
	"sort"
	"strconv"
	"time"
)

func H() {
	println("OK")
}

// Map functions return a slice of KeyValue.
type KeyValue struct {
	Key   string
	Value string
}

// for sorting by key.
type ByKey []KeyValue

// for sorting by key.
func (a ByKey) Len() int           { return len(a) }
func (a ByKey) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a ByKey) Less(i, j int) bool { return a[i].Key < a[j].Key }

// use ihash(key) % NReduce to choose the reduce
// task number for each KeyValue emitted by Map.
func ihash(key string) int {
	h := fnv.New32a()
	h.Write([]byte(key))
	return int(h.Sum32() & 0x7fffffff)
}

// main/mrworker.go calls this function.
func Worker(mapf func(string, string) []KeyValue,
	reducef func(string, []string) string) {

	for {
		reply := CallCoordinator()
		if reply.TaskType == "map" {
			executeMap(mapf, reply)
		} else if reply.TaskType == "reduce" {
			executeReduce(reducef, reply)
		} else {
			time.Sleep(1 * time.Second)
		}
	}

}

// example function to show how to make an RPC call to the coordinator.
//
// the RPC argument and reply types are defined in rpc.go.
func CallCoordinator() MrReply {

	// declare an argument structure.
	args := MrArgs{}

	// fill in the argument(s).

	// declare a reply structure.
	reply := MrReply{}

	// send the RPC request, wait for the reply.
	// the "Coordinator.DistributeTask" tells the
	// receiving server that we'd like to call
	// the DistributeTask() method of struct Coordinator.
	call("Coordinator.DistributeTask", &args, &reply)
	return reply
}

// send an RPC request to the coordinator, wait for the response.
// usually returns true.
// returns false if something goes wrong.
func call(rpcname string, args interface{}, reply interface{}) bool {
	// c, err := rpc.DialHTTP("tcp", "127.0.0.1"+":1234")
	sockname := coordinatorSock()
	c, err := rpc.DialHTTP("unix", sockname)
	if err != nil {
		log.Fatal("dialing:", err)
	}
	defer c.Close()

	err = c.Call(rpcname, args, reply)
	if err == nil {
		return true
	}

	fmt.Println(err)
	return false
}

// mapping code
func executeMap(mapf func(string, string) []KeyValue, reply MrReply) {
	fileName := reply.MapFileName
	file, err := os.Open(fileName)

	if err != nil {
		log.Fatalf("cannot open %v", fileName)
	}

	content, err := io.ReadAll(file)
	if err != nil {
		log.Fatalf("cannot read %v", fileName)
	}

	kva := mapf(fileName, string(content))
	kvap := ArrangeIntermediate(kva, reply.NReduce)
	files := []string{}

	for i := range kvap {
		values := kvap[i]
		filename := "mr-" + strconv.Itoa(reply.Index) + "-" + strconv.Itoa(i)
		ofile, _ := os.Create(filename)
		defer ofile.Close()
		enc := json.NewEncoder(ofile)
		for _, kv := range values {
			err := enc.Encode(&kv)
			if err != nil {
				log.Fatal("error: ", err)
			}
		}

		files = append(files, filename)
		NotifyMaster(i, filename)
	}

	NotifyMapSuccess(fileName)
}

func executeReduce(reducef func(string, []string) string, reply MrReply) {
	intermediate := []KeyValue{}
	for _, v := range reply.Files {
		file, err := os.Open(v)
		if err != nil {
			log.Fatal("cannot open %v", v)
		}
		defer file.Close()

		dec := json.NewDecoder(file)
		for {
			var kv KeyValue
			if err := dec.Decode(&kv); err != nil {
				break
			}

			intermediate = append(intermediate, kv)
		}
	}

	sort.Sort(ByKey(intermediate))

	oname := "mr-out-" + strconv.Itoa(reply.Index)
	ofile, _ := os.Create(oname)

	i := 0
	for i < len(intermediate) {
		j := i + 1
		for j < len(intermediate) && intermediate[j].Key == intermediate[i].Key {
			j++
		}
		values := []string{}
		for k := i; k < j; k++ {
			values = append(values, intermediate[k].Value)
		}
		output := reducef(intermediate[i].Key, values)
		fmt.Fprintf(ofile, "%v %v\n", intermediate[i].Key, output)
		i = j
	}
	NotifyReduceSuccess(reply.Index)
}

func ArrangeIntermediate(kva []KeyValue, nReduce int) [][]KeyValue {
	kvap := make([][]KeyValue, nReduce)
	for _, kv := range kva {
		v := ihash(kv.Key) % nReduce
		kvap[v] = append(kvap[v], kv)
	}
	return kvap
}

func NotifyMapSuccess(filename string) {
	args := NotifyMapSuccessArgs{}
	args.File = filename
	reply := NotifyReply{}
	call("Coordinator.NotifyMapSuccess", &args, &reply)
}

func NotifyReduceSuccess(reduceIndex int) {
	args := NotifyReduceSuccessArgs{}
	args.ReduceIndex = reduceIndex
	reply := NotifyReply{}
	call("Coordinator.NotifyReduceSuccess", &args, &reply)
}

func NotifyMaster(reduceIndex int, file string) {
	args := NotifyIntermediateArgs{}
	args.ReduceIndex = reduceIndex
	args.File = file
	reply := NotifyReply{}
	call("Coordinator.NotifyIntermediateFile", &args, &reply)
}
