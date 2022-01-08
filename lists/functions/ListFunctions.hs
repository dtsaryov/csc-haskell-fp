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

{-
GHCi> sum3 [1,2,3] [4,5] [6]
[11,7,3]
-}
sum3 :: Num a => [a] -> [a] -> [a] -> [a]
sum3 xs ys zs = sum' [] xs ys zs where
  sum' acc [] [] [] = reverse acc
  sum' acc xs' ys' zs' = sum' ((x + y + z) : acc) (stail xs') (stail ys') (stail zs') where
    stail [] = []
    stail qs = tail qs

    shead [] = 0
    shead qs = head qs

    x = shead xs'
    y = shead ys'
    z = shead zs'

{-
GHCi> groupElems []
[]

GHCi> groupElems [1,2]
[[1],[2]]

GHCi> groupElems [1,2,2,2,4]
[[1],[2,2,2],[4]]

GHCi> groupElems [1,2,3,2,4]
[[1],[2],[3],[2],[4]]
-}
groupElems :: Eq a => [a] -> [[a]]
groupElems xs = group [] xs where
  group acc [] = reverse acc
  group acc xs' = group (sameEls : acc) diffEls where
    head' = head xs'
    (sameEls, diffEls) = span (== head') xs'