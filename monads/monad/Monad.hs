module Monad where

import Control.Monad (liftM, ap)

{-
GHCi> add1Log 3
Log ["added one"] 4

GHCi> mult2Log 3
Log ["multiplied by 2"] 6
-}
data Log a = Log [String] a deriving Show

toLogger :: (a -> b) -> String -> (a -> Log b)
toLogger f msg = Log [msg] . f

add1Log = toLogger (+1) "added one"
mult2Log = toLogger (*2) "multiplied by 2"

{-
GHCi> execLoggers 3 add1Log mult2Log
Log ["added one","multiplied by 2"] 8
-}
execLoggers :: a -> (a -> Log b) -> (b -> Log c) -> Log c
execLoggers x f g = let (Log fs b) = f x in
                    let (Log gs c) = g b in
                    Log (fs ++ gs) c

returnLog :: a -> Log a
returnLog = Log []

{-
GHCi> Log ["nothing done yet"] 0 `bindLog` add1Log
Log ["nothing done yet","added one"] 1

GHCi> Log ["nothing done yet"] 3 `bindLog` add1Log `bindLog` mult2Log
Log ["nothing done yet","added one","multiplied by 2"] 8
-}
bindLog :: Log a -> (a -> Log b) -> Log b
bindLog (Log xs x) f = Log (xs ++ ys) y where
  (Log ys y) = f x

instance Functor Log where
    fmap = liftM

instance Applicative Log where
    pure  = return
    (<*>) = ap

instance Monad Log where
    return = returnLog
    (>>=) = bindLog

{-
GHCi> execLoggersList 3 [add1Log, mult2Log, \x -> Log ["multiplied by 100"] (x * 100)]
Log ["added one","multiplied by 2","multiplied by 100"] 800
-}
execLoggersList :: a -> [a -> Log a] -> Log a
execLoggersList x = foldl (>>=) $ return x