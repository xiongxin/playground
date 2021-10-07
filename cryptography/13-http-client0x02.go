package main

import (
	"crypto/tls"
	"crypto/x509"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

func main() {

	caCertInfo, err := ioutil.ReadFile("server.crt")
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}

	caCertPool := x509.NewCertPool()
	caCertPool.AppendCertsFromPEM(caCertInfo)

	clientCertificate, err := tls.LoadX509KeyPair("client.crt", "client.key")
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}

	cfg := tls.Config{
		// 服务器的ca池
		RootCAs: caCertPool,
		// 客户端证书
		Certificates: []tls.Certificate{clientCertificate},
	}

	client := http.Client{
		Transport: &http.Transport{
			TLSClientConfig: &cfg,
		},
	}

	resp, err := client.Get("https://localhost:8848")
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}
	defer resp.Body.Close()
	println(ioutil.ReadAll(resp.Body))
	println(resp.StatusCode)
}
