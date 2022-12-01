# USAGE ./do [flags] [day] [part (1 or 2)]
# flags:
#    -b Benchmark
#    -e use Example input
#    -c Cleanup intermediate files and executables

while getopts 'bec' o
do
	case $o in
		b) benchmark=1 ;;
		e) example=1 ;;
		c) cleanup=1 ;;
	esac
done
shift $((OPTIND - 1))

root=$(realpath ~/dev/aoc/2022)
day=$root/$(printf %02d $1)

if [ -d $day/bqn ]
then
	printf "bqn:     "
	if [[ $benchmark ]]
	then
		time bqn $day/bqn/00_$2.bqn $day/$([[ $example ]] && echo example.txt || echo input.txt)
		echo
	else
		bqn $day/bqn/00_$2.bqn $day/$([[ $example ]] && echo example.txt || echo input.txt)
	fi
fi

if [ -d $day/haskell ]
then
	cd $day/haskell
	ghc -v0 00_$2.hs $root/Helper.hs
	printf "haskell: "
	if [[ $benchmark ]]
	then
		time ./00_$2 $day/$([[ $example ]] && echo example.txt || echo input.txt)
		echo
	else
		./00_$2 $day/$([[ $example ]] && echo example.txt || echo input.txt)
	fi
	if [[ $cleanup ]]
	then
		rm 00_$2 00_$2.hi 00_$2.o $root/Helper.hi $root/Helper.o
	fi
	cd - > /dev/null
fi

if [ -d $day/odin ]
then
	printf "odin:    "
	cd $day/odin
	odin build 00_$2.odin -file
	if [[ $benchmark ]]
	then
		time ./00_$2.bin $day/$([[ $example ]] && echo example.txt || echo input.txt)
		echo
	else
		./00_$2.bin $day/$([[ $example ]] && echo example.txt || echo input.txt)
	fi
	if [[ $cleanup ]]
	then
		rm 00_$2.bin
	fi
	cd - > /dev/null
fi

if [ -d $day/rust ]
then
	printf "rust:    "
	cd $day/rust
	rustc 00_$2.rs
	if [[ $benchmark ]]
	then
		time ./00_$2 $day/$([[ $example ]] && echo example.txt || echo input.txt)
		echo
	else
		./00_$2 $day/$([[ $example ]] && echo example.txt || echo input.txt)
	fi
	if [[ $cleanup ]]
	then
		rm 00_$2
	fi
	cd - > /dev/null
fi