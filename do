# USAGE ./do [flags] [day] [part (1 or 2)]
# flags:
#    -e use Example input

while getopts 'e' o
do
	case $o in
		e) doexample=1 ;;
	esac
done
shift $((OPTIND - 1))

root=$(realpath ~/dev/aoc/2022)
dayn=$(printf %02d $1)
input=$root/input/${dayn}input.txt
example=$root/input/${dayn}example.txt

printf "bqn:     "
bqn $root/bqn.bqn $1 $2 $([[ $doexample ]] && echo $example || echo $input)

cd $root/haskell
stack build --silent
printf "haskell: "
stack run -- $1 $2 $([[ $doexample ]] && echo $example || echo $input)
cd - > /dev/null

printf "odin:    "
odin build $root/odin
$root/odin/.bin $1 $2 $([[ $doexample ]] && echo $example || echo $input)

printf "rust:    "
cd $root/rust
cargo run -q -- $1 $2 $([[ $doexample ]] && echo $example || echo $input)
cd - > /dev/null