module Polymorphism where

import Data.Function

getSecondFrom :: a -> b -> c -> b
getSecondFrom x y z = y

-- from Data.Function
{-
on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
on op f x y = f x `op` f y
-}
sumSquares = (+) `on` (^2)

{-
GHCi> multSecond ('A',2) ('E',7)
14
-}
multSecond = g `on` h
g = (*)
h = (snd)

-- 3 arg version of built-in 'on' operator
on3 :: (b -> b -> b -> c) -> (a -> b) -> a -> a -> a -> c
on3 op f x y z = op (f x) (f y) (f z)

{-
GHCi> let sum3squares = (\x y z -> x+y+z) `on3` (^2)
GHCi> sum3squares 1 2 3
14
-}
sum3squares = (\x y z -> x+y+z) `on3` (^2)
