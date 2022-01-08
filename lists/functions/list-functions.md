# 3.1 Working with Lists

## Basic List Operations

### Creation

1. `[]` - create an empty list
2. `a : []` - add the `a` element as a head

```
GHCi> 42 : []
[42]

GHCi> 1 : 2 : [3]
[1, 2, 3]
```

### Deconstruction

1. `head` - returns the first element of a list
2. `tail` - returns all elements in a list after the first element

```
GHCi> head [1, 2, 3]
1

GHCi> tail [1, 2, 3]
[2, 3] 
```

### Pattern Matching with Lists

We have the `fst` function that can be used to return the first element
of a pair. It can be implemented like this:

```haskell
fst' (x, y) = x
```

Function declaration uses pattern matching to destructure a pair to its elements.

We can use the same idea to implement `head` function:

```haskell
head' (x : xs) = x
```

Since we do not use`xs` we can replace its name to `_`:

```haskell
head' (x : _) = x
```

It can be used to simplify the `scnd` function implementation:

```haskell
scnd xs = head (tail xs)
-- point-less implementation
scnd' = head . tail
-- pattern matching
scnd'' (_ : xs) = head xs
-- simplified pattern matching
scnd''' (_ : x : _) = x
```

## Recursive Approach

Recursive implementation of the `length` function:

```haskell
length [] = 0
length (_ : xs) = 1 + length xs 
```

Recursive implementation of the `++` operator:

```haskell
[] ++ ys = ys
(x : xs) ++ ys = x : xs ++ ys
```

## Useful Functions

1. `take n xs` - returns first `n` elements from `xs`
2. `drop n xs` - return all remaining elements of `xs` after the first `n` elements
3. `splitAt n xs` - divides `xs` after n-th element
4. `xs !! n` - returns n-th element from `xs`