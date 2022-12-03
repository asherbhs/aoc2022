# USAGE ./do [flags] [day] [part (1 or 2)]
# flags:
#    -e use Example input

# why did I do this when I only have one flag
while getopts 'e' o
do
	case $o in
		e) doexample=1 ;;
	esac
done
shift $((OPTIND - 1))

dayn=$(printf %02d $1)
input=$(realpath input/${dayn}input.txt)
example=$(realpath input/${dayn}example.txt)

printf "bqn:     "
bqn bqn.bqn $1 $2 $([[ $doexample ]] && echo $example || echo $input)

cd haskell
stack build --silent
printf "haskell: "
stack run -- $1 $2 $([[ $doexample ]] && echo $example || echo $input)
cd ..

printf "odin:    "
odin build odin
odin/.bin $1 $2 $([[ $doexample ]] && echo $example || echo $input)

printf "rust:    "
cd rust
cargo run -q -- $1 $2 $([[ $doexample ]] && echo $example || echo $input)
cd ..