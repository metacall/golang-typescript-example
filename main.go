package main

import (
	"fmt"
	"os"
	metacall "github.com/metacall/core/source/ports/go_port/source"
)

func main() {
	// Initialize MetaCall
	if err := metacall.Initialize(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	// Defer MetaCall destruction
	defer metacall.Destroy()

	scripts := []string{ "script.ts" }

	if err := metacall.LoadFromFile("ts", scripts); err != nil {
		fmt.Println(err)
		return
	}

	ret, err := metacall.Call("sum", 30.0, 20.0)

	if err != nil {
		fmt.Println(err)
		return
	}

	if result, ok := ret.(float64); ok {
		fmt.Println("30 + 20 =", result)
	} else {
		fmt.Println("An error ocurred when executing the call.")
	}
}
