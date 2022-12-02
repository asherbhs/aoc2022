use std::env;
use std::fs;

// DAY 1

fn day01part01(input: String) -> i32 {
	input
		.as_str()
		.split("\n\n")
		.map(|elf| elf
			.lines()
			.map(|c| c.parse::<i32>().unwrap())
			.sum::<i32>()
		)
		.max()
		.unwrap()
}

fn day01part02(input: String) -> i32 {
	let mut elves = input
		.as_str()
		.split("\n\n")
		.map(|elf| elf
			.lines()
			.map(|c| c.parse::<i32>().unwrap())
			.sum::<i32>()
		)
		.collect::<Vec<_>>();

	elves.sort();

	elves
		.into_iter()
		.rev()
		.take(3)
		.sum::<i32>()
}

//

fn main() {
	let mut args = env::args();
	args.next();
	let (Some(day),   Some(part),  Some(file)) =
		(args.next(), args.next(), args.next()) else { unreachable!(); };
	let input = fs::read_to_string(file).unwrap();
	println!("{}", match (day.parse::<i32>().unwrap(), part.parse::<i32>().unwrap()) {
		(1, 1) => day01part01(input).to_string(),
		(1, 2) => day01part02(input).to_string(),
		_ => unreachable!(),
	});
}
