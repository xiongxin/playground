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
	println("服务器启动。。。")
	caInfo, err := ioutil.ReadFile("client.crt")
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}

	caPool := x509.NewCertPool()
	caPool.AppendCertsFromPEM(caInfo)

	cfg := tls.Config{
		ClientAuth: tls.RequireAndVerifyClientCert,
		ClientCAs:  caPool,
	}

	httpServer := http.Server{
		Addr:      ":8848",
		Handler:   nil,
		TLSConfig: &cfg,
	}

	if httpServer.ListenAndServeTLS("server.crt", "server.key") != nil {
		log.Fatal("服务器启动失败")
		os.Exit(1)
	}
}
