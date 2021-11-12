package main

import (
	"fmt"
	"net/http"
)

func main() {
	response, err := http.Head("")
	checkError(err)

	fmt.Println(response.Status)
	for k, v := range response.Header
}

func checkError(err error) {
	if err != nil {
		fmt.Println("Fatal error ", err.Error())
		panic(err)
	}
}
