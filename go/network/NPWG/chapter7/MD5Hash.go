package main

import (
	"crypto/md5"
	"fmt"
	"os"
)

func main() {
	hash := md5.New()
	bytes := []byte("hello\n")
	hash.Write(bytes)
	hashValue := hash.Sum(nil)

	fmt.Printf("%x\n", hashValue)
	fmt.Fprintf(os.Stdout, "%x\n", hashValue)
}
