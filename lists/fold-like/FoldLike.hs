{-# LANGUAGE NoMonomorphismRestriction #-}
module FoldLike where

import Data.List

{-
GHCi> lastElem [0]
0

GHCi> lastElem [0, 1]
1
-}
lastElem :: [a] -> a
lastElem = foldl1 (\_ y -> y)

{-
GHCi> revRange ('a','z')
"zyxwvutsrqponmlkjihgfedcba"
-}
revRange :: (Char,Char) -> [Char]
revRange (lb, rb) = unfoldr g rb
  where g x = if x >= lb then Just (x, pred x) else Nothing

revRange' = unfoldr g where
  g (lb, ch) | lb <= ch = Just (ch, (lb, pred ch))
             | otherwise = Nothing