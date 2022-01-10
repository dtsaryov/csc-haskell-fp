{-# LANGUAGE NoMonomorphismRestriction #-}
module FoldRight where

{-
GHCi> concatList [[1,2],[],[3]]
[1,2,3]
-}
concatList :: [[a]] -> [a]
concatList = foldr (++) []

{-
GHCi> sumPosSquares [1,-2,3]
10
-}
sumPosSquares = foldr f 0 where
  f x s | x > 0     = x ^ 2 + s
        | otherwise = s

{-
GHCi> lengthList [7,6,5]
3
-}
lengthList :: [a] -> Int
lengthList = foldr f 0 where
  f _ s = s + 1

{-
GHCi> sumOdd [2,5,30,37]
42
-}
sumOdd :: [Integer] -> Integer
sumOdd = foldr (\x s -> if x `mod` 2 == 1 then s + x else s) 0