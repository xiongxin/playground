package main

import (
	"crypto/hmac"
	"crypto/sha256"
	"fmt"
)

// generate HMAC
func generateHMAC(src, key []byte) []byte {
	hash := hmac.New(sha256.New, key)
	hash.Write(src)
	mac := hash.Sum(nil)

	return mac
}

// authorize message code
func verifyHMAC(mac1, mac2 []byte) bool {

	// step1: get source data

	// step2: get source mac1

	// step3: generate source data mac1

	// step4: mac1 == mac2
	return hmac.Equal(mac1, mac2)
}

func main() {
	src := []byte("hello world")
	key := []byte("1234567890")

	mac1 := generateHMAC(src, key)

	fmt.Printf("mac1 %x", mac1)
}
