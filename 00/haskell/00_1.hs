import System.Environment (getArgs)
import Helper (windows2)

main :: IO ()
main = do
    args <- getArgs
    input <- readFile (head args)
    let depths = map read $ lines input :: [Int]
    print
        $ length
        $ filter (uncurry (<))
        $ windows2 depths
