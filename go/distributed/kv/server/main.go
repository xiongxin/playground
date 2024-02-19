package main

import (
	"log"
	"net"
	"net/rpc"
	"sync"
	"xiongxin/common"
)

type KV struct {
	mu   sync.Mutex
	data map[string]string
}

func server() {
	kv := new(KV)
	kv.data = map[string]string{}
	rpcs := rpc.NewServer()
	rpcs.Register(kv)
	l, e := net.Listen("tcp", ":1234")
	if e != nil {
		log.Fatal("listen error:", e)
	}
	go func() {
		for {
			conn, err := l.Accept()
			if err == nil {
				go rpcs.ServeConn(conn)
			} else {
				break
			}
		}
		l.Close()
	}()
}

func (kv *KV) Get(args *common.GetArgs, reply *common.GetReply) error {
	kv.mu.Lock()
	defer kv.mu.Unlock()

	val, ok := kv.data[args.Key]
	if ok {
		reply.Err = common.OK
		reply.Value = val
	} else {
		reply.Err = common.ErrNoKey
		reply.Value = ""
	}
	return nil
}

func (kv *KV) Put(args *common.PutArgs, reply *common.PutReply) error {
	kv.mu.Lock()
	defer kv.mu.Unlock()

	kv.data[args.Key] = args.Value
	reply.Err = common.OK
	return nil
}

func main() {
	server()

	for {
	}
}
