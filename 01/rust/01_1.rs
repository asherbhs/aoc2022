use std::env;
use std::fs;

fn main() {
	println!("{}",
		fs::read_to_string(env::args().nth(1).unwrap())
			.unwrap()
			.as_str()
			.split("\n\n")
			.map(|elf| elf
				.lines()
				.map(|c| c.parse::<i32>().unwrap())
				.sum::<i32>()
			)
			.max()
			.unwrap()
	);
}