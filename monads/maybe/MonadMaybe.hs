module MonadMaybe where

import Data.Char

data Token = Number Int | Plus | Minus | LeftBrace | RightBrace
    deriving (Eq, Show)

{-
GHCi> asToken "123"
Just (Number 123)

GHCi> asToken "abc"
Nothing
-}
asToken :: String -> Maybe Token
asToken s | all isDigit s = Just (Number (read s :: Int))
          | s == "+"      = Just Plus
          | s == "-"      = Just Minus
          | s == "("      = Just LeftBrace
          | s == ")"      = Just RightBrace
          | otherwise = Nothing

{-
GHCi> tokenize "1 + 2"
Just [Number 1,Plus,Number 2]

GHCi> tokenize "1 + ( 7 - 2 )"
Just [Number 1,Plus,LeftBrace,Number 7,Minus,Number 2,RightBrace]

GHCi> tokenize "1 + abc"
Nothing
-}
tokenize :: String -> Maybe [Token]
tokenize input = sequence $ map asToken $ words input

{-
a^2 + b^2 = c^2
0 < a < b
0 < c <= x

GHCi> pythagoreanTriple 5
[(3,4,5)]

GHCi> pythagoreanTriple 0
[]

GHCi> pythagoreanTriple 10
[(3,4,5),(6,8,10)]
-}
pythagoreanTriple :: Int -> [(Int, Int, Int)]
pythagoreanTriple x = do
    a <- [1..x]
    b <- [1..a]
    c <- [1..x]
    True <- return (a ^ 2 + b ^ 2 == c ^ 2)
    return (b, a, c)