package main

import (
	"crypto"
	"crypto/rand"
	"crypto/rsa"
	"crypto/sha256"
	"crypto/x509"
	"encoding/pem"
	"fmt"
	"io/ioutil"
	"os"
)

/*
1. 提供私钥文件，解析出私钥内容(decode, parse)
2. 使用私钥数字签名


认证
1. 提供公钥文件
2. 使用公钥进行数字签名认证

*/
func rsaSignData(filename string, src []byte) ([]byte, error) {
	info, err := ioutil.ReadFile(filename)
	if err != nil {
		return nil, err
	}

	// pem decode, get der code in block
	block, _ := pem.Decode(info)

	// decode der to get private key
	derText := block.Bytes
	privateKey, err := x509.ParsePKCS1PrivateKey(derText)

	if err != nil {
		return nil, err
	}

	// sign data
	hash := sha256.Sum256(src)

	return rsa.SignPKCS1v15(rand.Reader, privateKey, crypto.SHA256, hash[:])
}

func verifySignature(filename string, sig, src []byte) error {
	info, err := ioutil.ReadFile(filename)
	if err != nil {
		return err
	}

	block, _ := pem.Decode(info)

	derText := block.Bytes
	publicKey, err := x509.ParsePKCS1PublicKey(derText)

	if err != nil {
		return err
	}
	// sign data
	hash := sha256.Sum256(src)
	return rsa.VerifyPKCS1v15(publicKey, crypto.SHA256, hash[:], sig)
}

func main() {

	// 这里提供原始数据
	src := []byte("hello world!!!!")

	signData, err := rsaSignData("private.pem", src)

	if err != nil {
		fmt.Errorf("前面失败!, err: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("signa data : %x\n", signData)
	fmt.Printf("signa data : %s\n", signData)

	fmt.Printf("signa data : %s\n", verifySignature("public.pem", signData, src))

	// 验证成功，说明发送方可信
}
