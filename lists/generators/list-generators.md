# 3.3 List Generators

An infinite list can be generated with a recursive function without terminating case:

```haskell
ones :: [Integer]
ones = 1 : ones -- [1,1,1,1,1,1,1,1,...]

naturals :: [Integer]
naturals n = 1 : naturals (n + 1) -- [1,2,3,4,5,6,7,8,9,...]
```

## Dealing with Infinite Lists

The `take n xs` function returns first `n` elements from `xs` list, but it also
can be used with infinite lists:

```haskell
fiveOnes = take 5 ones -- [1,1,1,1,1]
```

It happens due to lazy computational model:

```haskell
head (x:xs) = x
ones = 1 : ones

firstOne = head ones
{-
after the first reduction of ones will be pattern matches with `x:xs`
~> head 1 : ones
~> 1
-}
```

## Infinite List Generation

1. `repeat a` - produces an infinite list containing `a` elements:

```haskell
fiveOnes = take 5 $ repeat 1 -- [1, 1, 1, 1, 1]
```

2. `replicate n x` - generates a list that contains `n` `x` elements:

```haskell
fiveOnes = replicate 5 1 -- [1, 1, 1, 1, 1]
```

3. `cycle xs` - generates a list containing repeated elements from `xs`

```haskell
onesAndTwos = take 6 $ cycle [1, 2] -- [1, 2, 1, 2, 1, 2]
```

4. `iterate f x` - generates a list started with `x` and then sequentially applied `f`

```haskell
fromZeroToNine = take 10 $ iterate (+1) 0 -- [0,1,2,3,4,5,6,7,8,9]
```

## Arithmetic Sequences

The `[lb..ub]` expression is used to generate sequences, where `lb` is a lower bound
and `ub` is an upper bound:

```haskell
fromZeroToTen = [0..10] -- [0,1,2,3,4,5,6,7,8,9,10]
```

To specify a step of a sequence we have to use two elements in the beginning:

```haskell
odds = [1, 3..10] -- [1, 3, 5, 7, 9]
```

These expressions are syntax sugar for the `enumFromTo` and `enumFromThenTo` functions.

### Infinite Arithmetic Sequences

The same approach can be used to generate infinite sequences:

```haskell
naturals = [1..] -- [1, 2, 3, 4, 5, 6, ...]
odds = [1,3..] -- [1, 3, 5, 7, 9, ...]
```

## List Comprehension

Basic syntax: `[f x | x <- xs]`, for example:

```haskell
squares = [x ^ 2 | x <- [1..10]] -- [1, 4, 9, 16, ...]
```

### Conditions

Get squares of natural numbers that a lesser than 10:

```haskell
squares = [x ^ 2 | x <- [1..10], x ^ 2 < 10] -- [1, 4, 9]
```