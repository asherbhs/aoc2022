
package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:slice"

main :: proc() {
	input_bytes, _ := os.read_entire_file_from_filename(os.args[1])
	defer delete(input_bytes)

	depths := make([]int, slice.count(input_bytes, '\n'))
	defer delete(depths)

	input := string(input_bytes)
	for line, i in strings.split_lines(input) {
		if len(line) == 0 { continue }
		depths[i] = strconv.atoi(line)
	}

	sums := make([]int, len(depths) - 2)
	defer delete(sums)
	for _, i in sums {
		sums[i] = depths[i] + depths[i + 1] + depths[i + 2]
	}

	increases := 0
	for i in 0 ..< len(sums) - 1 {
		if sums[i] < sums[i + 1] {
			increases += 1
		}
	}
	fmt.println(increases)
}