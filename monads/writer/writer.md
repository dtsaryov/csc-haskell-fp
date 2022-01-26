# 5.7 Writer

## Definition Variant

`w` - "output" type (monoid)
`a` - result type (any)

```haskell
newtype Writer w a = Writer { runWriter :: (a, w) }

-- runWriter :: Writer a w -> (a, w)

writer :: (a, w) -> Writer w a
writer = Writer

execWriter :: Writer w a -> w
execWriter m = snd (runWriter m)

evalWriter :: Writer w a -> a
evalWriter m = fst (runWriter m)

instance (Monoid w) => Monad (Writer w) where
  return x = Writer (x, mempty)
  m >>= k =
      let (x, u) = runWriter m
          (y, v) = runWriter $ k x
      in Writer (y, u 'mappend' v)
```

## Usage

```
GHCi> runWriter (return 3 :: Writer (Sum Int) Int)
(3, Sum {getSum=0})

GHCi> runWriter (return 3 :: Writer (Product Int) Int)
(3, Product {getProduct=1})
```