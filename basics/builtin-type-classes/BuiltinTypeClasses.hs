module BuiltInTypeClasses where

-- WAAAGH!
class KnownToGork a where
    stomp :: a -> a
    doesEnrageGork :: a -> Bool

class KnownToMork a where
    stab :: a -> a
    doesEnrageMork :: a -> Bool

class (KnownToGork a, KnownToMork a) => KnownToGorkAndMork a where
    stompOrStab :: a -> a
    stompOrStab orc = getResult (doesEnrageGork orc) (doesEnrageMork orc) where
      getResult True  False  = stab orc
      getResult False True   = stomp orc
      getResult True  True   = stomp (stab orc)
      getResult False False  = orc

-- "127.224.120.12"
ip = show a ++ show b ++ show c ++ show d where
  a = 127.2
  b = 24.1
  c = 20.1
  d = 2

{-
GHCi> ssucc True
False

GHCi> spred False
True
-}
class (Eq a, Bounded a, Enum a) => SafeEnum a where
  ssucc :: a -> a
  ssucc e | maxBound == e = minBound
          | otherwise     = succ e

  spred :: a -> a
  spred e | minBound == e = maxBound
          | otherwise     = pred e

instance SafeEnum Bool

avg :: Int -> Int -> Int -> Double
avg x y z = (toDouble x + toDouble y + toDouble z) / 3 where
  toDouble a = fromIntegral a :: Double