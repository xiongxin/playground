package core

//
// RPC definitions.
//
// remember to capitalize all names.
//

import (
	"os"
	"strconv"
)

//
// example to show how to declare the arguments
// and reply for an RPC.
//

type ExampleArgs struct {
	X int
}

type ExampleReply struct {
	Y int
}

type MrArgs struct {
}

type MrReply struct {
	MapFileName string
	TaskType    string
	Index       int
	NReduce     int
	Files       []string
}

type NotifyIntermediateArgs struct {
	ReduceIndex int
	File        string
}

type NotifyReply struct {
}

type NotifyMapSuccessArgs struct {
	File string
}

type NotifyReduceSuccessArgs struct {
	ReduceIndex int
}

// Add your RPC definitions here.

// Cook up a unique-ish UNIX-domain socket name
// in /var/tmp, for the coordinator.
// Can't use the current directory since
// Athena AFS doesn't support UNIX-domain sockets.
func coordinatorSock() string {
	s := "/var/tmp/5840-mr-"
	s += strconv.Itoa(os.Getuid())
	return s
}
