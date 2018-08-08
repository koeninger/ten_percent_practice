/*
Exercise 1.4: Modify dup2 to print the names of 
all files in which each duplicated line occurs.
*/
package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	counts := make(map[string]int)
	filenames := make(map[string]map[string]int)
	files := os.Args[1:]

	if len(files) == 0 {
		countLines(os.Stdin, counts, filenames, "stdin")
	
	} else {
		for _, arg := range files {
			f, err := os.Open(arg)

			if err != nil {
				fmt.Fprintf(os.Stderr, "dup2: %v\n", err)
				continue
			}

			countLines(f, counts, filenames, arg)
			f.Close()
		}
	}

	for line, n := range counts {
		if n > 1 {
			fmt.Printf("%d\t%s\n", n, line)
			for fname, _ := range filenames[line] {
				fmt.Println(fname)
			}
		}
	}
}

func countLines(file *os.File, counts map[string]int, filenames map[string]map[string]int, filename string) {
	input := bufio.NewScanner(file)

	for input.Scan() {
		line := input.Text()
		counts[line]++

		if filenames[line] == nil {
			filenames[line] = make(map[string]int)
		}
		filenames[line][filename]++
	}
	// NOTE: Ignoring potential errors from input.Err()
}