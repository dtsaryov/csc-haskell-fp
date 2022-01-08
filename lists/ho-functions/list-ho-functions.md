# 3.2 Lists - Higher Order Functions

1. `filter predicate xs` - returns a list of elements from `xs` that match `predicate`:

```haskell
lessThan3 = filter (< 3) [1, 2, 3, 4, 2, 1, 0] -- [1, 2, 2, 1, 0]
```

2. `takeWhile predicate xs` - the same as filter, but stops when predicate
is not matched:

```haskell
lessThan3 = filter (< 3) [1, 2, 3, 4, 2, 1, 0] -- [1, 2]
```

3. `dropWhile predicate xs` - skips first elements that do not match predicate

4. `map f xs` - creates a new list that contains elements from `xs` processed by `f`:

```haskell
squares = map (^2) [1, 2, 3] -- [1, 4, 9]
```

5. `concatMap f xs` - elements from `xs` are mapped by `f` that returns list,
then these lists a concatenated:

```haskell
letters = concatMap (\x -> [x, x, x]) "ABCD" -- AAABBBCCCDDD
```

6. `all predicate xs` - return `True` if all elements from `xs` match the `predicate`

```haskell
onlyOdds = all odd [1, 2, 3] -- False
```

7. `any predicate xs` - return `True` if any element from `xs` matches the `predicate`

```haskell
anyEven = any even [1, 2, 3] -- True
```

8. `zip xs ys` - returns a list of pairs created from list elements: `[(x1, y1), (x2, y2), ...]`
9. `zipWith f xs ys` - returns a list of elements produced by `f :: x -> y -> z`