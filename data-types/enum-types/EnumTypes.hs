{-# LANGUAGE NoMonomorphismRestriction #-}
module EnumTypes where

data Color = Red | Green | Blue

instance Show Color where
    show color = case color of Red   -> "Red"
                               Green -> "Green"
                               Blue  -> "Blue"
{-
GHCi> charToInt '0'
0
GHCi> charToInt '9'
9
-}
charToInt :: Char -> Int
charToInt char = fromEnum char - 48

{-
GHCi> stringToColor "Red"
Red
-}
stringToColor :: String -> Color
stringToColor s | s == "Red" = Red
                | s == "Green" = Green
                | s == "Blue" = Blue

data LogLevel = Error | Warning | Info

{-
GHCi> cmp Error Warning
GT
GHCi> cmp Info Warning
LT
GHCi> cmp Warning Warning
EQ

Error > Warning > Info
-}
cmp :: LogLevel -> LogLevel -> Ordering
cmp Warning Info = GT
cmp Warning Error = LT
cmp Error Error = EQ
cmp Warning Warning = EQ
cmp Info Info = EQ
cmp Error _ = GT
cmp Info _  = LT

data Result = Fail | Success
doSomeWork :: (Result,Int)
doSomeWork = (Fail, -1)
--doSomeWork = (Success, 0)

processData :: String
processData = format (result, code) where
  format (Success, _) = "Success"
  format (_, code) = "Fail: " ++ show code
  (result, code) = doSomeWork

