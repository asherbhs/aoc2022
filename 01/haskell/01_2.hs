import System.Environment (getArgs)
import Helper (splitOn)
import Data.List (sort)

main :: IO ()
main = do
    args <- getArgs
    input <- readFile (head args)
    let elves = map (map read . lines) $ splitOn "\n\n" input :: [[Int]]
    print $ sum $ take 3 $ reverse $ sort $ map sum elves