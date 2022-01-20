# 5.3 Identity

```haskell
newtype Identity a = Identity { runIdentity :: a }
  deriving (Eq, Show)
  
instance Monad Identity where
  return x = Identity x
  Identity x >>= k = k x
  
instance Functor Identity where
  fmap  f (Identity x) = Identity (f x)

instance Applicative Identity where
  pure x = Identity x
  Identity f <*> Identity v = Identity (f v) 
```

## Monad Laws

### Left Identity

`return a >>= k ≡ k a`

### Right Identity

`m >>= return ≡ m`

### Associativity

`(m >>= k) >>= k' ≡ m >>= (\x -> k x >>= k')`