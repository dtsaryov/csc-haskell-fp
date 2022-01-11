# 3.6 Fold Like Functions

## `foldr1` and `foldl1`

These two functions work with one-element lists:

```haskell
foldr1 :: Foldable t => (a -> a -> a) -> t a -> a
foldr1 _ [x] = x
foldr1 f (x:xs) = f x (foldr1 f xs)
foldr1 _ [] = error "Empty list"

foldl1 :: Foldable t => (a -> a -> a) -> t a -> a
foldl1 f (x:xs) = foldl f x xs
foldl1 _ [] = error "Empty list"
```

## `scanr` and `scanl`

These two functions generate a list of sequentially applied function to
initial list elements with saving intermediate values (like iterate).

```haskell
scanr :: (a -> b -> b) -> b -> [a] -> [b]
scanr _ ini [] = [ini]
scanr f ini (x:xs) = (x `f` q) : qs where
  qs@(q:_) = scanr f ini xs
```

```haskell
scanl :: (b -> a -> b) -> b -> [a] -> [b]
scanl f ini [] = [ini]
scal f ini (x:xs) = init : scanl f (ini `f` x) xs
```

## `unfold`

Generates a list from some value by applying a function:

```haskell
unfold :: (b -> (a, b)) -> b -> [a]
unfold f ini = let (x, ini') = f ini in
  x : unfold f ini'
```

The `iterate` function can be implemented with `unfold`:

```haskell
iterate' f = unfold (\x -> (x, f x))
```

## `Maybe`

```
GHCi> :t Nothing
Nothing :: Maybe a

GHCi> :t Just
Just :: a -> Maybe a

GHCi> :t Just True
Just True :: Maybe Bool


```

## `unfoldr`

```haskell
unfoldr :: (b -> Maybe (a, b)) -> b -> [a]
unfoldr f ini = helper (f ini) where
    f (Just (x, ini')) = x : unfoldr f ini'
    f Nothing          = []
```