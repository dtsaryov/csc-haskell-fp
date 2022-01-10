# 3.4 Fold Right

There are few examples of folding:

```haskell
sumList :: [Integer] -> Integer
sumList [] = 0
sumList (x:xs) = x + sumList xs

concatList :: [[a]] -> [a]
concatList [] = []
concatList (x:xs) = x ++ concatList xs
```

The generic function that performs these operations can be implemented like this:

```haskell
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f initial [] = initial
foldr f initial (x:xs) = f x foldr f initial

(:) x (:) x (:) x []
```

