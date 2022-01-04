module LocalBinding where

roots a b c =
  let {
    d = sqrt (b ^ 2 - 4 * a * c);
    x1 = (-b - d) / (2 * a);
    x2 = (-b + d) / (2 * a)} in
  (x1, x2)

factorial n
  | n >= 0 = let
      helper acc 0 = acc
      helper acc n = helper (acc * n) (n - 1)
    in helper 1 n
  | otherwise = error "n must be >= 0"

-- a0 = 1, a1 = 2, a2 = 3
-- a_k = a_(k-1) + a_(k-2) - 2a_(k-3)
-- a_(k+3) = a_(k+2) + a_(k+1) - 2a_k

-- simple recursive solution
seqA n | n < 3 = n + 1
       | n >= 3  = seqA (n - 1) + seqA (n - 2) - 2 * seqA (n - 3)

-- with accumulation
seqAcc n
  | n >= 0 = let
      helper k3 k2 k1 n | n < 2  = n + 1
                        | n == 2 = k3
                        | otherwise = helper (k3 + k2 - 2 * k1) k3 k2 (n - 1)
    in helper 3 2 1 n
  | n < 0 = error "n must be >= 0"

--
sum'n'count :: Integer -> (Integer, Integer)
sum'n'count x = (sum, count) where
  (sum, count, _) = process (0, 0, abs x) where
    process (s, c, 0) = if c == 0 then (s, 1, 0) else (s, c, 0)
    process (s, c, x) = process (s + x `mod` 10, c + 1, x `div` 10)

--
{-
I = h ( (f0 + fn) / 2 + sum (fi, [1, n - 1]) )
h = (b - a) / n
-}
integration :: (Double -> Double) -> Double -> Double -> Double
integration f a b = h * (((f_0 + f_n) / 2) + f_sum) where
  n = 1000
  h = (b - a) / n

  x_i i = a + h * i
  f_i i = f (x_i i)

  f_0 = f_i 0
  f_n = f_i n

  f_sum = f_sum' 0 1 where
    f_sum' sum i | i == n     = sum
                 | otherwise  = f_sum' (sum + (f_i i)) (i + 1)

-- sum of first n positive numbers
mySum n = sum' 0 0 where
  sum' acc i | i == n    = acc
             | otherwise = sum' (acc + (i + 1)) (i + 1)