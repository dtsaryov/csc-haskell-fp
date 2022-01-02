module Operators where

-- define custom operator with left associativity and 6 priority
infixl 6 *+*
(*+*) a b = a ^ 2 + b ^ 2

{- reduction:
1 + 3 *+* 2 * 2 -- result: 32
~> 1 + 3 *+* 4
~> 4 *+* 4
~> 16
-}

x |-| y = abs (x - y)

-- section - partial operator application

divBy2 = (/ 2)
-- divBy2 8 // result: 4

div2By = (2 /)
-- div2By 2 // result: 1

{- complex section example
(`mod` 14) ((+ 5) 10)
~> (`mod` 14) 15
~> 15 `mod` 14
~> 1
-}

-- how to use '$' to omit parentheses

logBase 4 (min 20 (9 + 7))
logBase 4 $ min 20 $ 9 + 7

