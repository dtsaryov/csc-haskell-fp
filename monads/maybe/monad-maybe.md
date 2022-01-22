# 5.4 Monads - Maybe

```haskell
instance Monad Maybe where
  return = Just
  
  (Just x) >>= k = k x
  Nothing >>= _ = Nothing
  
  (Just _) >> m = m
  Nothing  >> m = Nothing
  
  fail _ = Nothing
```