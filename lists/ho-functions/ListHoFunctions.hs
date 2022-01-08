module ListHoFunctions where

import Data.Char

{-
GHCi> readDigits "365ads"
("365","ads")

GHCi> readDigits "365"
("365","")
-}
readDigits = span isDigit

{-
GHCi> filterDisj (< 10) odd [7,8,10,11,12]
[7,8,11]
-}
filterDisj :: (a -> Bool) -> (a -> Bool) -> [a] -> [a]
filterDisj p1 p2 xs = filter p1orp2 xs where
  p1orp2 = \x -> p1 x || p2 x

{-
GHCi> qsort [1,3,2,5]
[1,2,3,5]
-}
qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort xs@(x:xs') = (qsort ys) ++ [x] ++ (qsort zs) where
  ys = tail (filter (<= x) xs)
  zs = filter (> x) xs

{-
GHCi> squares'n'cubes [3,4,5]
[9,27,16,64,25,125]
-}
squares'n'cubes :: Num a => [a] -> [a]
squares'n'cubes [] = []
squares'n'cubes (x:xs) = x^2 : x ^ 3 : squares'n'cubes xs

{-
GHCi> perms [1,2,3]
[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
-}
perms :: [a] -> [[a]]
perms []     = [[]]
perms (x:xs) = concatMap (rotations . (x:)) (perms xs) where
  rotations xs = take (length xs) (iterate (\(y:ys) -> ys ++ [y]) xs)

{-
GHCi> delAllUpper "Abc IS not ABC"
"Abc not"
-}
delAllUpper :: String -> String
delAllUpper = unwords . filter (any isLower) . words

{-
GHCi> max3 [7,2,9] [3,6,8] [1,8,10]
[7,8,10]
GHCi> max3 "AXZ" "YDW" "MLK"
"YXZ"
-}
max3 :: Ord a => [a] -> [a] -> [a] -> [a]
max3 = zipWith3 (\x y z -> max x (max y z))