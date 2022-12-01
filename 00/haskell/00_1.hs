import System.Environment (getArgs)

windows2 :: [a] -> [(a, a)]
windows2 (x : y : t) = (x, y) : windows2 (y : t)
windows2 _ = []

main :: IO ()
main = do
    args <- getArgs
    input <- readFile (head args)
    let depths = map read $ lines input :: [Int]
    print
        $ length
        $ filter (uncurry (<))
        $ windows2 depths
