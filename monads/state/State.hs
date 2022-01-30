module State where

import Control.Monad

data Reader r a = Reader { runReader :: (r -> a) }

asks = Reader

instance Functor (Reader r) where
    fmap = liftM

instance Applicative (Reader r) where
    pure  = return
    (<*>) = ap

instance Monad (Reader r) where
  return x = Reader $ \_ -> x
  m >>= k  = Reader $ \r -> runReader (k (runReader m r)) r

instance Functor (State r) where
    fmap = liftM

instance Applicative (State r) where
    pure  = return
    (<*>) = ap

newtype State s a = State { runState :: s -> (a, s) }

instance Monad (State s) where
  return a = State $ \st -> (a, st)

  m >>= k = State $ \st ->
    let (a, st') = runState m st
        m' = k a
    in runState m' st'

execState :: State s a -> s -> s
execState m s = snd (runState m s)

evalState :: State s a -> s -> a
evalState m s = fst (runState m s)

get :: State s s
get = State $ \st -> (st, st)

put :: s -> State s ()
put st = State $ \_ -> ((), st)

{-
GHCi> evalState (readerToState $ asks (+2)) 4
6

GHCi> runState (readerToState $ asks (+2)) 4
(6,4)
-}
readerToState :: Reader r a -> State r a
readerToState m = State $ \x -> (runReader m x, x)

{-
GHCi> runState (writerToState $ tell "world") "hello,"
((),"hello,world")
GHCi> runState (writerToState $ tell "world") mempty
((),"world")
-}
newtype Writer w a = Writer { runWriter :: (a, w) }

writer :: (a, w) -> Writer w a
writer = Writer

execWriter :: Writer w a -> w
execWriter m = snd (runWriter m)

evalWriter :: Writer w a -> a
evalWriter m = fst (runWriter m)

tell :: Monoid w => w -> Writer w ()
tell w = writer ((), w)

instance (Monoid w) => Applicative (Writer w) where
  pure = return
  (<*>) = ap

instance (Monoid w) => Functor (Writer w) where
  fmap = liftM

instance (Monoid w) => Monad (Writer w) where
  return x = Writer (x, mempty)
  m >>= k =
      let (x, u) = runWriter m
          (y, v) = runWriter $ k x
      in Writer (y, u `mappend` v)

writerToState :: Monoid w => Writer w a -> State w a
writerToState m = let (a, w) = runWriter m
                  in State $ \x -> (a, x <> w)

{-
GHCi> execState fibStep (0,1)
(1,1)
GHCi> execState fibStep (1,1)
(1,2)
GHCi> execState fibStep (1,2)
(2,3)
-}
fibStep :: State (Integer, Integer) ()
fibStep = State $ \(x1, x2) -> ((), (x2, x1 + x2))

execStateN :: Int -> State s a -> s -> s
execStateN n m = execState $ replicateM n m

fib :: Int -> Integer
fib n = fst $ execStateN n fibStep (0, 1)