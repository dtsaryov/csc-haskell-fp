{-# LANGUAGE NoMonomorphismRestriction #-}
module ListGenerators where

import Data.List

{-
GHCi> take 10 $ fibStream
[0,1,1,2,3,5,8,13,21,34]
-}
fibStream :: [Integer]
fibStream = 0 : 1 : zipWith (+) fibStream (tail fibStream)

-- repeat = iterate repeatHelper
repeat' = iterate repeatHelper
repeatHelper = id

{-
GHCi> succ $ Odd (-100000000000003)
Odd (-100000000000001)
-}
data Odd = Odd Integer deriving (Eq,Show)

instance Enum Odd where
  succ (Odd n) = Odd $ n + 2
  pred (Odd n) = Odd $ n - 2

  toEnum = Odd . toInteger
  fromEnum (Odd n) = fromIntegral n

  enumFrom = iterate succ
  enumFromThen (Odd n1) (Odd n2) = map Odd [n1, n2..]

  enumFromTo (Odd n1) (Odd nn) = map Odd . filterOdd $ [n1..nn] where
    filterOdd = filter (\x -> x `mod` 2 == 1)

  enumFromThenTo (Odd n1) (Odd n2) (Odd nn) = map Odd . filterOdd $ [n1, n2..nn] where
    filterOdd = filter (\x -> x `mod` 2 == 1)

{-
GHCi> change 7
[[2,2,3],[2,3,2],[3,2,2],[7]]
-}
coins = [2,3,7]

change :: (Ord a, Num a) => a -> [[a]]
change n | n < 0 = []
         | n == 0 = []
         | otherwise = filter (\xs -> sum xs == n)
            [ x : xs | x <- coins,
                       xs <- [[]] ++ change (n - x) ]