import System.Environment (getArgs)
import Helper (windows, windows2, count)

main :: IO ()
main = do
    args <- getArgs
    input <- readFile (head args)
    let depths = map read $ lines input :: [Int]
    print
        $ count (uncurry (<))
        $ windows2
        $ map sum
        $ windows 3 depths
