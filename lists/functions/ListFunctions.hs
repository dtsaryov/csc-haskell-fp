module ListFunctions where

{-
GHCi> addTwoElements 2 12 [85,0,6]
[2,12,85,0,6]
-}

addTwoElements :: a -> a -> [a] -> [a]
addTwoElements x y list = x : y : list

{-
GHCi> nTimes 42 3
[42,42,42]
GHCi> nTimes 'z' 5
"zzzzz"
-}

nTimes a n = repeat [] n where
  repeat ls 0 = ls
  repeat ls n = repeat (a : ls) (n - 1)

fst' (x, y) = x

head' (x : xs) = x

sndHead = snd . head
sndHead' (x : _) = snd x
sndHead'' ((_, x) : _) = x
sndHead''' ((_, x) : _) = x
sndHead'''' ((,) x y : _) = y
sndHead''''' ((,) _ y : _) = y

{-
GHCi> oddsOnly [2,5,7,10,11,12]
[5,7,11]
-}
oddsOnly :: Integral a => [a] -> [a]
oddsOnly [] = []
oddsOnly (x:xs) = ifOdd x ++ oddsOnly xs where
  ifOdd x | x `mod` 2 == 1 = [x]
          | otherwise      = []

{-
GHCi> isPalindrome "saippuakivikauppias"
True
GHCi> isPalindrome [1]
True
GHCi> isPalindrome [1, 2]
False
-}
isPalindrome xs = reverse xs == xs