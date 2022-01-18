# 5.1 Functor

```haskell
class Functor f where
  fmap :: (a -> b) -> f a -> f b

instance Functor [] where
  fmap = map

instance Functor Maybe where
  fmap _ Nothing = Nothing
  fmap f (Just a) = Just (f a)
```

`fmap` can be used with infix style:

```haskell
squares = (^2) <$> [1,2,3]
```

## Tuple

```haskell
instance Functor ((,) a) where
  fmap f (x, y) = (x, f y)
```

## Either

```haskell
instance Functor (Either a) where
  fmap _ (Left x) = Left x
  fmap f (Right x) = Right $ f x
```

## Arrow

```haskell
instance Functor ((->) e) where
  fmap = (.)

len = fmap length tail "ABC" -- result: 2
```

## Laws

1. `fmap id = id`
2. `fmap (f . g) = fmap f . fmap g`

```haskell
GHCi> (fmap (+1) . fmap (^2)) [1,2,3]
[2,5,10]

GHCi> fmap ((+1) . (^2)) [1,2,3]
[2,5,10]
```