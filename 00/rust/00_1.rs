use std::env;
use std::fs;

fn main() {
	println!("{}",
		fs::read_to_string(env::args().nth(1).unwrap())
			.unwrap()
			.as_str()
			.lines()
			.map(|it| it.parse::<i32>().unwrap())
			.collect::<Vec<_>>()
			.windows(2)
			.filter(|w|
				if let [x, y] = w {
					x < y
				} else {
					unreachable!()
				}
			)
			.count(),
	);
}