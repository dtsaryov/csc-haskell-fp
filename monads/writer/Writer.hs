module Writer where

import Control.Monad (liftM, ap)
import Data.Monoid

newtype Writer w a = Writer { runWriter :: (a, w) }

writer :: (a, w) -> Writer w a
writer = Writer

execWriter :: Writer w a -> w
execWriter m = snd (runWriter m)

evalWriter :: Writer w a -> a
evalWriter m = fst (runWriter m)

instance (Monoid w) => Applicative (Writer w) where
  pure = return
  (<*>) = ap

instance (Monoid w) => Functor (Writer w) where
  fmap = liftM

instance (Monoid w) => Monad (Writer w) where
  return x = Writer (x, mempty)
  m >>= k =
      let (x, u) = runWriter m
          (y, v) = runWriter $ k x
      in Writer (y, u `mappend` v)

{-
GHCi> total shopping1
19708
-}
type Shopping = Writer (Sum Integer) ()

shopping1 :: Shopping
shopping1 = do
  purchase "Jeans"   19200
  purchase "Water"     180
  purchase "Lettuce"   328

purchase :: String -> Integer -> Shopping
purchase item cost = writer ((), Sum cost)

total :: Shopping -> Integer
total = getSum . execWriter

{-
GHCi> total shopping2
19708
GHCi> items shopping2
["Jeans","Water","Lettuce"]
-}
type Shopping' = Writer ([String], Sum Integer) ()

shopping2 :: Shopping'
shopping2 = do
  purchase' "Jeans"   19200
  purchase' "Water"     180
  purchase' "Lettuce"   328

purchase' :: String -> Integer -> Shopping'
purchase' item cost = writer ((), ([item], Sum cost))

total' :: Shopping' -> Integer
total' = getSum . snd . execWriter

items' :: Shopping' -> [String]
items' = fst . execWriter