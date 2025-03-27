package main

import "fmt"

// var not const
var (
	version = "set-with-x-flag"
)

func main() {
	fmt.Println("hello world (version: " + version + ")")
}
