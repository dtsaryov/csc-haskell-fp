module TypeProducts where

import Data.List

data Point = Point Double Double

origin :: Point
origin = Point 0.0 0.0

distanceToOrigin :: Point -> Double
distanceToOrigin (Point x y) = sqrt (x ^ 2 + y ^ 2)

distance :: Point -> Point -> Double
distance (Point x1 y1) (Point x2 y2) =
  sqrt ((x2 - x1) ^ 2 + (y2 - y1) ^ 2)

data Shape = Circle Double | Rectangle Double Double

area :: Shape -> Double
area (Circle r) = pi * (r ^ 2)
area (Rectangle a b) = a * b

{-
> doSomeWork' $ SomeData 0
Success
> doSomeWork' $ SomeData -1
Fail: -1
-}
data Result = Fail | Success

data SomeData = SomeData Int

doSomeWork :: SomeData -> (Result,Int)
-- for testing purpose
doSomeWork (SomeData code) = case code of 0 -> (Success, 0)
                                          _ -> (Fail, code)

data Result' = Result' Int

instance Show Result' where
    show (Result' code) | code == 0 = "Success"
                        | otherwise = "Fail: " ++ show code

doSomeWork' :: SomeData -> Result'
doSomeWork' sd = Result' $ snd (doSomeWork sd)

{-
> isSquare $ square 4
True
-}
square :: Double -> Shape
square a = Rectangle a a

isSquare :: Shape -> Bool
isSquare (Rectangle a b) = a == b
isSquare _ = False

-- Bit Arithmetic
data Bit = Zero | One deriving (Eq, Show)
data Sign = Minus | Plus deriving (Eq, Show)
data Z = Z Sign [Bit] deriving (Eq, Show)

signToNum :: Sign -> Integer
signToNum Minus = -1
signToNum Plus = 1

toDec :: Z -> Integer
toDec (Z sign bits) = signToNum sign * (fst $ foldl f (0, 0) bits) where
  f (acc, power) bit = (acc + nth, power + 1) where
    nth | power == 0 && num == 0 = 0
        | otherwise              = num ^ power
    num = case bit of One  -> 2
                      Zero -> 0

-- Inverted presentation: 6 <-> [0, 1, 1]
toBin :: Integer -> Z
toBin n = Z (numToSign n) (map toBit . binNum $ abs n) where
  binNum 0 = []
  binNum 1 = [1]
  binNum n = (n `mod` 2 : binNum (n `div` 2))
  toBit 0 = Zero
  toBit 1 = One
  numToSign n = case signum n of -1 -> Minus
                                 _  -> Plus

add :: Z -> Z -> Z
add b1 b2 = toBin (toDec b1 + toDec b2)

mul :: Z -> Z -> Z
mul b1 b2 = toBin (toDec b1 * toDec b2)