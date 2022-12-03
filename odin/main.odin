package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:slice"

// DAY 1

day01part1 :: proc(input: string) -> int {
	sums: [dynamic]int = {0}
	defer delete(sums)

	for line in strings.split_lines(input) {
		if len(line) == 0 {
			append(&sums, 0)
		} else {
			sums[len(sums) - 1] += strconv.atoi(line)
		}
	}

	return slice.max(sums[:])
}

day01part2 :: proc(input: string) -> int {
	sums: [dynamic]int = {0}
	defer delete(sums)

	for line in strings.split_lines(input) {
		if len(line) == 0 {
			append(&sums, 0)
		} else {
			sums[len(sums) - 1] += strconv.atoi(line)
		}
	}

	bronze, silver, gold := 0, 0, 0
	for sum in sums {
		if sum > gold {
			bronze = silver
			silver = gold
			gold   = sum
		} else if sum > silver {
			bronze = silver
			silver = sum
		} else if sum > bronze {
			bronze = sum
		}
	}

	return bronze + silver + gold
}

// DAY 2

day02part1 :: proc(input: string) -> int {
	score := 0
	for line in strings.split_lines(input) {
		if len(line) == 0 { continue } // final line
		opp := int(line[0] - 'A')
		you := int(line[2] - 'X')
		score += 3 * ((you + 1 - opp + 3) % 3) + 1 + you
	}
	return score
}

day02part2 :: proc(input: string) -> int {
	score := 0
	for line in strings.split_lines(input) {
		if len(line) == 0 { continue }
		opp := int(line[0] - 'A')
		you := (int(line[2]) - int('Y') + opp + 3) % 3
		score += 3 * ((you + 1 - opp + 3) % 3) + 1 + you
	}
	return score
}

main :: proc() {
	input_bytes, _ := os.read_entire_file_from_filename(os.args[3])
	defer delete(input_bytes)
	input := string(input_bytes)

	switch strconv.atoi(os.args[1]) {
	case 1:
		switch strconv.atoi(os.args[2]) {
		case 1: fmt.println(day01part1(input))
		case 2: fmt.println(day01part2(input))
		}
	case 2:
		switch strconv.atoi(os.args[2]) {
		case 1: fmt.println(day02part1(input))
		case 2: fmt.println(day02part2(input))
		}
	case 3: fmt.println()
	}
}