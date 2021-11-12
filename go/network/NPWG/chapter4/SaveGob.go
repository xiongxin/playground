package main

import (
	"encoding/gob"
	"fmt"
	"os"
)

type Person struct {
	Name  Name
	Email []Email
}

type Name struct {
	Family   string
	Personal string
}

type Email struct {
	Kind    string
	Address string
}

func (p Person) String() string {
	s := p.Name.Personal + " " + p.Name.Family
	for _, v := range p.Email {
		s += "\n" + v.Kind + ": " + v.Address
	}
	return s
}

func main() {
	person := Person{
		Name: Name{Family: "Newmarch", Personal: "Jan"},
		Email: []Email{{Kind: "home", Address: "jan@newmarch.name"},
			{Kind: "work", Address: "j.newmarch@boxhill.edu.au"}}}

	saveGob("person.gob", person)
	println("======Parse Person=======")
	var person1 Person
	loadGob("person.gob", &person1)
	fmt.Println(person.String())
}

func saveGob(filename string, key interface{}) {
	outFile, err := os.Create(filename)
	defer outFile.Close()
	checkError(err)
	encoder := gob.NewEncoder(outFile)
	err = encoder.Encode(key)
	checkError(err)
}

func loadGob(filename string, key interface{}) {
	inFile, err := os.Open(filename)
	defer inFile.Close()
	checkError(err)
	decoder := gob.NewDecoder(inFile)
	err = decoder.Decode(key)
	checkError(err)
}

func checkError(err error) {
	if err != nil {
		fmt.Println("Fatal error ", err.Error())
		panic(err)
	}
}
