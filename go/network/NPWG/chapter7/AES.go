package main

import (
	"bytes"
	"crypto/aes"
	"fmt"
)

func main() {
	key := []byte("my key, len 16 b")
	cipher, err := aes.NewCipher(key)

	if err != nil {
		fmt.Println(err.Error())
	}
	src := []byte("hello 16 b block")

	var enc [16]byte
	cipher.Encrypt(enc[:], src)

	fmt.Printf("%x\n", enc)

	var dec [16]byte
	cipher.Decrypt(dec[:], enc[:])
	println(string(dec[:]))
	result := bytes.NewBuffer(nil)
	result.Write(dec[:])
	fmt.Println(string(result.Bytes()))
}
