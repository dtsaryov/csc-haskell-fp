module Polymorphism where

import Data.Function

getSecondFrom :: a -> b -> c -> b
getSecondFrom x y z = y

{-
from Data.Function:

on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
on op f x y = f x `op` f y
-}
sumSquares = (+) `on` (^2)

{-
GHCi> multSecond ('A',2) ('E',7)
14
-}
multSecond = f `on` g where
  f = (*)
  g = (snd)

-- 3 args version of built-in 'on' operator
on3 :: (b -> b -> b -> c) -> (a -> b) -> a -> a -> a -> c
on3 op f x y z = op (f x) (f y) (f z)

{-
GHCi> let sum3squares = (\x y z -> x+y+z) `on3` (^2)
GHCi> sum3squares 1 2 3
14
-}
sum3squares = (\x y z -> x + y + z) `on3` (^2)

-- composition
doIt = f . g . h where
  f = \x -> x + 1
  g = \y -> y + 2
  h = \z -> z + 3

doItYourself = f . g . h where
  f = (logBase 2)
  g = (^3)
  h = max 42

{-
how many different functions (results are different) with the following type can be implemented?
p :: a -> (a, b) -> a -> (b, a, a)

p1 x (y, z) c = (z, x, y)
p2 x (y, z) c = (z, y, x)
p3 x (y, z) c = (z, x, c)
p4 x (y, z) c = (z, c, x)
p5 x (y, z) c = (z, y, c)
p6 x (y, z) c = (z, c, y)
p7 x (y, z) c = (z, x, x)
p8 x (y, z) c = (z, y, y)
p9 x (y, z) c = (z, c, c)

Solution: n ^ k = 3 ^ 2 = 9
-}

{-
implement swap with combination of: curry uncurry flip (,) const
swap :: (a,b) -> (b,a)
-}
swap' = f (g h) where
  f = uncurry
  g = flip
  h = (,)