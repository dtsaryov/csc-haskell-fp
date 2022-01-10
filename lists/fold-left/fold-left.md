# 3.5 Fold Left

```haskell
foldl :: (b -> a -> b) -> b -> [a] -> b
foldl f ini [] = ini
foldl f ini (x:xs) = foldl f (f ini x) xs
```

It is not recommended using `foldl` because it generates a lot of delayed
evaluations (redexes).

There is a `foldl'` function that uses the `seq` operator to force computations.

## Multiple Folding Functions Usage

```haskell
sumAndProduct = foldr (\x (sum, product) -> (sum + x, product * x)) (0, 1)
```