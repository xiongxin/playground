package main

import (
	"crypto/rand"
	"crypto/rsa"
	"crypto/x509"
	"encoding/gob"
	"encoding/pem"
	"fmt"
	"os"
)

func main() {
	reader := rand.Reader
	bitSize := 512
	key, err := rsa.GenerateKey(reader, bitSize)
	checkError(err)

	fmt.Println("Private key primes: ", key.Primes[0].String(), key.Primes[1].String())
	fmt.Println("Private key exponent", key.D.String())

	publicKey := key.PublicKey
	fmt.Println("Public key modulus: ", publicKey.N.String())
	fmt.Println("Public key exponent: ", publicKey.E)

	saveGobKey("private.key", key)
	saveGobKey("public.key", publicKey)

	savePEMKey("private.pem", key)
}

func saveGobKey(filename string, key interface{}) {
	outFile, err := os.Create(filename)
	checkError(err)
	defer outFile.Close()
	encoder := gob.NewEncoder(outFile)
	err = encoder.Encode(key)
	checkError(err)
}

func savePEMKey(filename string, key *rsa.PrivateKey) {
	outFile, err := os.Create(filename)
	checkError(err)
	defer outFile.Close()
	var privateKey = &pem.Block{
		Type:  "RSA PRIVATE KEY",
		Bytes: x509.MarshalPKCS1PrivateKey(key),
	}
	err = pem.Encode(outFile, privateKey)
	checkError(err)
}

func checkError(err error) {
	if err != nil {
		fmt.Println("Fatal error ", err.Error())
		panic(err)
	}
}
