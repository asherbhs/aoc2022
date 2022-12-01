use std::env;
use std::fs;

fn main() {
	println!("{}",
		fs::read_to_string(env::args().nth(1).unwrap())
			.unwrap()
			.as_str()
			.lines()
			.map(|line| line.parse::<i32>().unwrap())
			.collect::<Vec<_>>()
			.windows(3)
			.map(|win| win.iter().sum::<i32>())
			.collect::<Vec<_>>()
			.windows(2)
			.filter(|win|
				if let [x, y] = win {
					x < y
				} else {
					unreachable!()
				}
			)
			.count(),
	);
}