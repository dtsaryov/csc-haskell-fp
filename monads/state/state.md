# 5.8 State

```haskell
newtype State s a = State { runState :: s -> (a, s) }

-- runState :: State s a -> s -> (a, s)

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

tick :: State Int Int
tick = do
    n <- get
    put (n + 1)
    return n

modify :: s -> s -> State s ()
modify f = State $ \s -> ((), f s)
```
