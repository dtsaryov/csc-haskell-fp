module ParameterizedTypes where

import Data.Char
import Data.List

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

maybeToBool :: Maybe String -> Bool
maybeToBool Nothing = False
maybeToBool _ = True

data Error = ParsingError | IncompleteDataError | IncorrectDataError String deriving (Eq, Show)

data Person = Person { firstName :: String, lastName :: String, age :: Int } deriving (Eq, Show)

isPairMalformed :: (String, String) -> Bool
isPairMalformed (k, v) = length k == 0 || length v == 0

checkPairs :: [(String, String)] -> Either Error [(String, String)]
checkPairs pairs = if any isPairMalformed pairs then Left ParsingError else Right pairs

trim xs = dropSpaceTail "" $ dropWhile isSpace xs

dropSpaceTail maybeStuff "" = ""
dropSpaceTail maybeStuff (x:xs)
        | isSpace x = dropSpaceTail (x:maybeStuff) xs
        | null maybeStuff = x : dropSpaceTail "" xs
        | otherwise       = reverse maybeStuff ++ x : dropSpaceTail "" xs


stail "" = ""
stail s = tail s

toPair :: String -> (String, String)
toPair x = let (k, v) = span (/= '=') x
           in (trim k, trim $ stail v)

checkComplete :: Either Error [(String, String)] -> Either Error [(String, String)]
checkComplete (Left e) = Left e
checkComplete (Right pairs) | all (\key -> maybeToBool $ find (==key) (map fst pairs)) ["firstName", "lastName", "age"] = Right $ pairs
                            | otherwise = Left IncompleteDataError

parseLines :: [String] -> Either Error [(String, String)]
parseLines ls = checkAge $ checkComplete $ checkPairs $ map toPair ls

createP :: (Maybe String) ->
           (Maybe String) ->
           (Maybe String) ->
           Either Error Person

createP _ _ _ = Left IncompleteDataError
createP (Just fn) (Just ln) (Just age) =
    Right $ Person fn ln (read age :: Int)

createPerson :: Either Error [(String, String)] -> Either Error Person
createPerson (Left e) = Left e
createPerson (Right pairs) = createP fn ln age where
  fn = lookup "firstName" pairs
  ln = lookup "lastName" pairs
  age = lookup "age" pairs

assertAge :: Maybe String -> Bool
assertAge Nothing = False
assertAge (Just age) = all isDigit age

checkAge :: Either Error [(String, String)] -> Either Error [(String, String)]
checkAge (Left e) = Left e
checkAge (Right pairs) = case assertAge $ lookup "age" pairs of True -> Right pairs
                                                                otherwise -> Left $ IncorrectDataError "age"

-- firstName = John\nlastName = Connor\nage = 30
parsePerson :: String -> Either Error Person
parsePerson = createPerson . (parseLines . lines)

------

eitherToMaybe :: Either a b -> Maybe a
eitherToMaybe (Left a) = Just a
eitherToMaybe (Right _) = Nothing
