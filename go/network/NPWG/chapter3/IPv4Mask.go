/*
* IPv4Mask
 */
package main

import (
	"fmt"
	"net"
	"os"
)

func main() {
	// if len(os.Args) != 2 {
	// 	fmt.Fprintf(os.Stderr, "Usage: %s dotted-ip-addr\n", os.Args[0])
	// 	os.Exit(1)
	// }

	dotAddr := "192.168.1.3"

	addr := net.ParseIP(dotAddr)
	if addr == nil {
		fmt.Println("Invlid address")
		os.Exit(1)
	}

	mask := addr.DefaultMask()
	network := addr.Mask(mask)
	ones, bits := mask.Size()

	fmt.Println("Address is ", addr.String(),
		"\nDefault mask length is ", bits,
		"\nLeading onew count is ", ones,
		"\nMask is (hex) ", mask.String(),
		"\nNetwork is ", network.String())
	os.Exit(0)
}
