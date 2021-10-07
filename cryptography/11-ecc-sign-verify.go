






// 签名和RSA类似
// Golang 仅仅支持ecc签名，不支持ecc加解密

package main

import (
	"crypto/ecdsa"
	"crypto/rand"
	"crypto/sha256"
	"crypto/x509"
	"encoding/pem"
	"errors"
	"fmt"
	"io/ioutil"
	"math/big"
)

type Signature struct {001
	r *big.Int
	s *big.Int
}

func eccSignData(filename string, src []byte) (*Signature, error) {
	info, err := ioutil.ReadFile(filename)
	if err != nil {
		return nil, err
	}

	// pem decode, get der code in block
	block, _ := pem.Decode(info)

	// decode der to get private key
	derText := block.Bytes
	privateKey, err := x509.ParseECPrivateKey(derText)

	if err != nil {
		return nil, err
	}

	// sign data
	hash := sha256.Sum256(src)

	r, s, err := ecdsa.Sign(rand.Reader, privateKey, hash[:])
	if err != nil {
		return nil, err
	}
	return &Signature{r, s}, nil
}

func eccVerifySignature(filename string, sig *Signature, src []byte) error {
	info, err := ioutil.ReadFile(filename)
	if err != nil {
		return err
	}

	block, _ := pem.Decode(info)

	derText := block.Bytes
	publicKey, err := x509.ParsePKIXPublicKey(derText)

	if err != nil {
		return err
	}
	// sign data
	hash := sha256.Sum256(src)
	if ecdsa.Verify(publicKey.(*ecdsa.PublicKey), hash[:], sig.r, sig.s) {
		return nil
	}

	return errors.New("签名验证失败")
}

// func eccVerifySig(filename string, src []byte, sig []byte) bool {}

func main() {
	src := []byte("hello world")
	sig, err := eccSignData("eccPrivate.pem", src)
	if err != nil {
		fmt.Printf("error : %v", err)
	}

	fmt.Printf("signdata: %s\n", sig)
	fmt.Printf("signdata: %v\n", sig)

	err = eccVerifySignature("eccPublic.pem", sig, src)
	if err != nil {
		fmt.Printf("error : %v\n", err)
	} else {
		fmt.Printf("验证成功\n")
	}
}
11111111111111111111111111111111111111111111111111111111111111111111
