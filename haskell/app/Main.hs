module Main (main) where

import Debug.Trace (traceShow)

import System.Environment (getArgs)
import Data.Function ((&))
import Data.List (sort, intercalate)

--- HELP ---

infixr 8 .:
(.:) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
(.:) f g x y = f (g x y)

count :: (a -> Bool) -> [a] -> Int
count = length .: filter

windows :: Int -> [a] -> [[a]]
windows n xs
    | n > 0     = windows' n xs
    | otherwise = error $ "windows: non-positive window size " ++ show n
  where
    windows' :: Int -> [a] -> [[a]]
    windows' n xs = case nextWindow n xs of
        Just w  -> w : windows' n (tail xs)
        Nothing -> []

    nextWindow :: Int -> [a] -> Maybe [a]
    nextWindow 0 _  = Just []
    nextWindow _ [] = Nothing
    nextWindow n (x : xs) = do
        windowTail <- nextWindow (n - 1) xs
        return (x : windowTail)

windows2 :: [a] -> [(a, a)]
windows2 (x : y : t) = (x, y) : windows2 (y : t)
windows2 _ = []

tiles :: Int -> [a] -> [[a]]
tiles n xs
    | n > 0     = tiles' n xs
    | otherwise = error $ "tiles: non-positive tile size " ++ show n
  where
    tiles' :: Int -> [a] -> [[a]]
    tiles' n xs = case nextTile n xs of
        Just t  -> t : tiles' n (drop n xs)
        Nothing -> []

    nextTile :: Int -> [a] -> Maybe [a]
    nextTile 0 _  = Just []
    nextTile _ [] = Nothing
    nextTile n (x : xs) = do
        tileTail <- nextTile (n - 1) xs
        return (x : tileTail)

tiles2 :: [a] -> [(a, a)]
tiles2 (x : y : t) = (x, y) : tiles2 t
tiles2 _ = []

splitOn :: Eq a => [a] -> [a] -> [[a]]
splitOn [] _ = error "splitOn: empty splitter"
splitOn d xs = splitOn' (length d) d xs
  where
    splitOn' _ _ [] = [[]]
    splitOn' n d xs@(h : t)
        | d == take n xs = [] : splitOn' n d (drop n xs)
        | otherwise      = let (y : ys) = splitOn' n d t in (h : y) : ys

--- DAY 1 ---

day01part1 :: String -> Int
day01part1 input =
  let
    elves = map (map read . lines) $ splitOn "\n\n" input :: [[Int]]
  in
    maximum $ map sum elves

day01part2 :: String -> Int
day01part2 input =
  let
    elves = map (map read . lines) $ splitOn "\n\n" input :: [[Int]]
  in
    sum $ take 3 $ reverse $ sort $ map sum elves

--- DAY2 ---

day02part1 :: String -> Int
day02part1
    = sum
    . map (\[x, _, y] ->
      let
        opp = fromEnum x - fromEnum 'A'
        you = fromEnum y - fromEnum 'X'
      in
        3 * ((you + 1 - opp) `mod` 3) + 1 + you
    )
    . lines

day02part2 :: String -> Int
day02part2
    = sum
    . map (\[x, _, y] ->
      let
        opp = fromEnum x - fromEnum 'A'
        you = (fromEnum y - fromEnum 'Y' + opp) `mod` 3
      in
        3 * ((you + 1 - opp) `mod` 3) + 1 + you
    )
    . lines

main :: IO ()
main = do
    [day, part, file] <- getArgs
    input <- readFile file
    putStrLn $ case (read day, read part) :: (Int, Int) of
        (1, 1) -> show $ day01part1 input
        (1, 2) -> show $ day01part2 input
        (2, 1) -> show $ day02part1 input
        (2, 2) -> show $ day02part2 input
        _ -> ""