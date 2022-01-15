module ParameterizedTypes where

import Data.Char(isDigit)

data Coord a = Coord a a deriving Show

distance :: Coord Double -> Coord Double -> Double
distance (Coord x1 y1) (Coord x2 y2) = sqrt $ (x2 - x1) ^ 2 + (y2 - y1) ^ 2

manhDistance :: Coord Int -> Coord Int -> Int
manhDistance (Coord x1 y1) (Coord x2 y2) = (abs $ x2 - x1) + (abs $ y2 - y1)

-- cell size -> cell coord -> cell center
getCenter :: Double -> Coord Int -> Coord Double
getCenter h (Coord i j) = Coord xc yc where
  xc = (h * (lb i) + h * (rb i)) / 2
  yc = (h * (lb j) + h * (rb j)) / 2

  lb idx = fromIntegral idx
  rb idx = fromIntegral (idx + 1)

-- cell size -> cell coord -> cell number
getCell :: Double -> Coord Double -> Coord Int
getCell h (Coord x y) = Coord i j where
  i = floor $ x / h
  j = floor $ y / h

------

findDigit :: [Char] -> Maybe Char
findDigit [] = Nothing
findDigit (x:xs) | isDigit x = Just x
                 | otherwise = findDigit xs

findDigitOrX :: [Char] -> Char
findDigitOrX xs = let result = findDigit xs
                  in case result of Nothing   -> 'X'
                                    (Just d)  -> d

------

maybeToList :: Maybe a -> [a]
maybeToList (Just x) = [x]
maybeToList Nothing = []

listToMaybe :: [a] -> Maybe a
listToMaybe (x:xs) = Just x
listToMaybe ([]) = Nothing

------

data Error = ParsingError | IncompleteDataError | IncorrectDataError String

data Person = Person { firstName :: String, lastName :: String, age :: Int }

-- firstName = John\nlastName = Connor\nage = 30
parsePerson :: String -> Either Error Person
parsePerson = undefined

------

eitherToMaybe :: Either a b -> Maybe a
eitherToMaybe (Left a) = Just a
eitherToMaybe (Right _) = Nothing
