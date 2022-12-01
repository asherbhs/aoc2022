package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:slice"

main :: proc() {
	input_bytes, _ := os.read_entire_file_from_filename(os.args[1])
	defer delete(input_bytes)

	sums: [dynamic]int = {0}
	defer delete(sums)

	for line in strings.split_lines(string(input_bytes)) {
		if len(line) == 0 {
			append(&sums, 0)
		} else {
			sums[len(sums) - 1] += strconv.atoi(line)
		}
	}

	fmt.println(slice.max(sums[:]))
}