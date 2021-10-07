// https://www.systutorials.com/how-to-generate-rsa-private-and-public-key-pair-in-go-lang/

/*

crypto/rsa
The package crypto/rsa implements RSA encryption as specified in PKCS #1 and RFC 8017.

The func GenerateKey(random io.Reader, bits int) (*PrivateKey, error) function generates an RSA keypair of the given bit size using the random source random (for example, crypto/rand.Reader, discussed below).

crypto/rand
The var Reader io.Reader struct is a global, shared instance of a cryptographically secure random number generator. On Linux, Reader uses getrandom(2) if available, /dev/urandom otherwise.

crypto/x509
The func MarshalPKCS1PrivateKey(key *rsa.PrivateKey) []byte function converts an RSA private key to PKCS #1, ASN.1 DER form. This kind of key is commonly encoded in PEM blocks of type "RSA PRIVATE KEY".

The func MarshalPKCS1PublicKey(key *rsa.PublicKey) []byte function converts an RSA public key to PKCS #1, ASN.1 DER form. This kind of key is commonly encoded in PEM blocks of type "RSA PUBLIC KEY".

encoding/pem
The func Encode(out io.Writer, b *Block) error function writes the PEM encoding of b to out.

The code to generate RSA private/public key pair in Go lang
With the above libraries available, we can generate a private/public key pair in Go lang by combining the Go lang standard libraries functions in a way like

rsa.GenerateKey() =>
x509.MarshalPKIXPublicKey() =>
pem.Encode()
We store the keys into a pair of files for the RSA private/public keys.

*/

package main

import (
	"crypto/rand"
	"crypto/rsa"
	"crypto/x509"
	"encoding/pem"
	"fmt"
	"os"
)

func main() {
	// generate key
	privatekey, err := rsa.GenerateKey(rand.Reader, 2048)
	if err != nil {
		fmt.Printf("Cannot generate RSA key\n")
		os.Exit(1)
	}
	publickey := &privatekey.PublicKey

	// dump private key to file
	var privateKeyBytes []byte = x509.MarshalPKCS1PrivateKey(privatekey)
	privateKeyBlock := &pem.Block{
		Type:  "RSA PRIVATE KEY",
		Bytes: privateKeyBytes,
	}
	privatePem, err := os.Create("private.pem")
	if err != nil {
		fmt.Printf("error when create private.pem: %s \n", err)
		os.Exit(1)
	}
	err = pem.Encode(privatePem, privateKeyBlock)
	if err != nil {
		fmt.Printf("error when encode private pem: %s \n", err)
		os.Exit(1)
	}

	// dump public key to file
	publicKeyBytes := x509.MarshalPKCS1PublicKey(publickey)
	publicKeyBlock := &pem.Block{
		Type:  "RSA PUBLIC KEY",
		Bytes: publicKeyBytes,
	}
	publicPem, err := os.Create("public.pem")
	if err != nil {
		fmt.Printf("error when create public.pem: %s \n", err)
		os.Exit(1)
	}
	err = pem.Encode(publicPem, publicKeyBlock)
	if err != nil {
		fmt.Printf("error when encode public pem: %s \n", err)
		os.Exit(1)
	}
}
