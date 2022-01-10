{-# LANGUAGE NoMonomorphismRestriction #-}
module FoldLeft where

import Data.List

{-
when the next function results will be equal

foldr (-) x [2,1,5]
foldl (-) x [2,1,5]

2 - 1 + 5 - x == x - 2 - 1 - 5
2 + 2 - 1 + 1 + 5 + 5 = 2x
x = 7
-}

{-
GHCi> meanList [1,2,3,4]
2.5

meanList = someFun . foldr someFoldingFun someIni
-}

meanList :: [Double] -> Double
meanList = avg' . foldr (\x (sum, n) -> (sum + x, n + 1)) (0, 0) where
  avg' (sum, n) = sum / n

{-
GHCi> evenOnly [1..10]
[2,4,6,8,10]
GHCi> evenOnly ['a'..'z']
"bdfhjlnprtvxz"
-}
evenOnly :: [a] -> [a]
evenOnly = fst . foldl f ([], 1) where
  f (xs, i) x | even i    = (xs ++ [x], i + 1)
              | otherwise = (xs, i + 1)

{-
modify to support infinite lists

correct solution:
evenOnly = snd . foldr (\x ~(xs, ys) -> (x : ys, xs)) ([], [])

'~' is not learned, so as is
-}
evenOnly' :: [a] -> [a]
evenOnly' xs = map fst $ filter p $ zip xs [1,2..] where
  p (x,i) = even i