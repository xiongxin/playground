package main

import (
	"encoding/asn1"
	"fmt"
)

func main() {
	val := 13
	fmt.Println("Before marshal/unmarshal: ", val)

	mdata, err := asn1.Marshal(val)
	checkError(err)

	var n int
	_, err = asn1.Unmarshal(mdata, &n)
	checkError(err)

	fmt.Println("After marshal/unmarshal: ", n)
}

func checkError(err error) {
	if err != nil {
		fmt.Println("Fatal error ", err.Error())
		panic(err)
	}
}
