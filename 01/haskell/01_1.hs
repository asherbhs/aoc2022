import System.Environment (getArgs)
import Helper (splitOn)

main :: IO ()
main = do
    args <- getArgs
    input <- readFile (head args)
    let elves = map (map read . lines) $ splitOn "\n\n" input :: [[Int]]
    print $ maximum $ map sum elves