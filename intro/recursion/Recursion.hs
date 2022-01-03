module Recursion where

-- recursion with 'if'
factorial n = if n == 0 then 1 else n * factorial (n - 1)

-- recursion with pattern matching
factorialPm 0 = 1
factorialPm n = n * factorialPm (n - 1)

-- factorial implementation with accumulator
factorialAcc n | n >= 0    = factHelper 1 n
               | otherwise = error "arg must be >= 0"

factHelper acc 0 = acc
factHelper acc n = factHelper (acc * n) (n - 1)

-- 7!! = 7 * 5 * 3 * 1, 8!! = 8 * 6 * 4 * 2
doubleFact :: Integer -> Integer
doubleFact 0 = 1
doubleFact 1 = 1
doubleFact n = n * doubleFact (n - 2)

-- fibonacci seq
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)

-- fibonacci seq with negative numbers
fibonacciNeg n | n == 0 = 0
               | n == 1 = 1
               | n < 0  = (-1) ^ (abs n + 1) * fibonacciNeg (abs n)
               | n > 0  = fibonacciNeg (n - 1) + fibonacciNeg (n - 2)

-- fibonacci seq with negative numbers and accumulator
fibAcc n | n >= 0 = fibHelper 0 1 n
         | n < 0  = (-1) ^ (abs n + 1) * fibAcc (abs n)

fibHelper n1 n2 n | n == 0    = 0
                  | n == 1    = n2
                  | otherwise = fibHelper n2 (n1 + n2) (n - 1)

fibonacciAcc n = fibOpt 0 1 n
fibOpt n1 n2 n | n == 0    = 0
               | n == 1    = n2
               | otherwise = fibOpt n2 (n1 + n2) (n - 1)