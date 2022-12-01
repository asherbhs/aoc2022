module Helper where

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

splitOnElem :: Eq a => a -> [a] -> [[a]]
splitOnElem x = foldr
    (\e (y : ys) -> if e == x then [] : y : ys else (e : y) : ys)
    [[]]

splitOn :: Eq a => [a] -> [a] -> [[a]]
splitOn [] _ = error "splitOn: empty splitter"
splitOn x y = splitOn' (length x) x y
  where
    splitOn' _ _ [] = [[]]
    splitOn' n x y
        | x == take n y = [] : splitOn' n x (drop n y)
        | otherwise = case splitOn x (tail y) of
            []     -> [[head y]]
            z : zs -> (head y : z) : zs