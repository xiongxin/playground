package main

import (
	"crypto/ecdsa"
	"crypto/elliptic"
	"crypto/rand"
	"crypto/x509"
	"encoding/pem"
	"fmt"
	"os"
)

// 生成私钥公钥

func generateEccKeypair() {
	// 选择椭圆曲线
	curve := elliptic.P256()

	// 生成私钥
	privateKey, err := ecdsa.GenerateKey(curve, rand.Reader)
	publickey := &privateKey.PublicKey
	if err != nil {
		println("ecdsa.GenerateKey error generating")
	}

	// x509编码
	derText, err := x509.MarshalECPrivateKey(privateKey)
	if err != nil {
		println("MarshalECPrivateKey error generating")
	}

	// 写入pem.Block
	pkBlock := pem.Block{
		Type:    "ECC PRIVATE KEY",
		Headers: nil,
		Bytes:   derText,
	}

	// pem encode
	pFile, err := os.Create("eccPrivate.pem")
	if err != nil {
		println("os.Create error generating")
	}

	defer pFile.Close()

	err = pem.Encode(pFile, &pkBlock)

	publicKeyBytes, err := x509.MarshalPKIXPublicKey(publickey)
	publicKeyBlock := &pem.Block{
		Type:  "ECC PUBLIC KEY",
		Bytes: publicKeyBytes,
	}
	publicPem, err := os.Create("eccPublic.pem")
	if err != nil {
		fmt.Printf("error when create eccPublic.pem: %s \n", err)
		os.Exit(1)
	}
	err = pem.Encode(publicPem, publicKeyBlock)
	if err != nil {
		fmt.Printf("error when encode public pem: %s \n", err)
		os.Exit(1)
	}
}

func main() {
	generateEccKeypair()
}
