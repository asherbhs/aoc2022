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
dayn=$(printf %02d $1)
day=$root/$dayn

if [ -d $day/bqn ]
then
	printf "bqn:     "
	if [[ $benchmark ]]
	then
		time bqn $day/bqn/${dayn}_$2.bqn $day/$([[ $example ]] && echo example.txt || echo input.txt)
		echo
	else
		bqn $day/bqn/${dayn}_$2.bqn $day/$([[ $example ]] && echo example.txt || echo input.txt)
	fi
fi

if [ -d $day/haskell ]
then
	cd $day/haskell
	ghc -v0 ${dayn}_$2.hs $root/Helper.hs
	printf "haskell: "
	if [[ $benchmark ]]
	then
		time ./${dayn}_$2 $day/$([[ $example ]] && echo example.txt || echo input.txt)
		echo
	else
		./${dayn}_$2 $day/$([[ $example ]] && echo example.txt || echo input.txt)
	fi
	if [[ $cleanup ]]
	then
		rm ${dayn}_$2 ${dayn}_$2.hi ${dayn}_$2.o $root/Helper.hi $root/Helper.o
	fi
	cd - > /dev/null
fi

if [ -d $day/odin ]
then
	printf "odin:    "
	cd $day/odin
	odin build ${dayn}_$2.odin -file
	if [[ $benchmark ]]
	then
		time ./${dayn}_$2.bin $day/$([[ $example ]] && echo example.txt || echo input.txt)
		echo
	else
		./${dayn}_$2.bin $day/$([[ $example ]] && echo example.txt || echo input.txt)
	fi
	if [[ $cleanup ]]
	then
		rm ${dayn}_$2.bin
	fi
	cd - > /dev/null
fi

if [ -d $day/rust ]
then
	printf "rust:    "
	cd $day/rust
	rustc ${dayn}_$2.rs
	if [[ $benchmark ]]
	then
		time ./${dayn}_$2 $day/$([[ $example ]] && echo example.txt || echo input.txt)
		echo
	else
		./${dayn}_$2 $day/$([[ $example ]] && echo example.txt || echo input.txt)
	fi
	if [[ $cleanup ]]
	then
		rm ${dayn}_$2
	fi
	cd - > /dev/null
fi