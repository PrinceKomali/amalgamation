package main

import "C"
import (
	"fmt"
)
//export golang
func golang() { // doesn't let me name the function `go` ????
	fmt.Println("Sent from Go")
}
func main() {}