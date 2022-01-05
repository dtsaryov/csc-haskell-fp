# 2.1 Function Polymorphism

A function that accepts the same args with different types is called polymorphic:

```haskell
-- '+' is polymorphic
integers = 1 + 2
doubles = 3.14 + 2.7
```

Function polymorphism types:

1. parametric - the same code is used for args with different types
2. special - different code handles different types

## Type Variables

```haskell
id x = x
```

its type:

```
GHCi> :type id
id :: a -> a
```

`a` is a type variable since the `id` function is polymorphic and doesn't have
any specified type.

Accepts two args and always return the first one: 
```haskell
k x y = x
```

```
GHCi> k 42 True
42

GHCi> :type k
k :: p1 -> p2 -> p1

GHCi> k' = k 42
GHCi> k' True
42
```

Built-in analog of `k x y = x` is the `const` function:

```
GHCi> k = const 42
GHCi> k 123
42
```

The built-in function `undefined` is also polymorphic:

```
GHCi> :type undefined
undefined :: a 
```

## Polymorphism Types

1. mono-morphism - explicit type is specified for all arguments:

```haskell
f :: Char -> Char
f c -> c
```

2. semi-morphism - type is not specified for some arguments:

```haskell
f :: Char -> a -> Char
f x y -> x
```

## Higher Order Functions

Such functions accept another function as an argument and / or return another
function as a result. For example:

```
GHCi> :t ($)
($) :: (a -> b) -> a -> b
```

The `$` operator accepts two arguments:

1. a function `a -> b`
2. an argument with type `a`

and returns a result with type `b`.

For the `min 4 $ 5` expression arguments are:

1. partially applied function `min 4`
2. `5`

One more example:

```
GHCi> applyTwice f x = f f x

GHCi> :t applyTwice
applyTwice :: (t -> t) -> t -> t

GHCi> applyTwice (+5) 0
10
```

### `flip`

Built-in function:

```haskell
flip f y x = f x y
```

Usage:

```
GHCi> flip (/) 3 6
2.0
```

### `on`

The `Data.Function` module has a function `on`:

```haskell
on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
on op f x y = f x `op` f y
```

It accepts one binary and one unary functions and can be used like this:

```haskell
sumSquares = (+) `on` (^2)
```

Usage:

```
GHCi> sumSqares 2 3
13
```

## Anonymous Functions

To use an anonymous function lambda-syntax can be used:

```
GHCi> (\x -> 2 * x + 7) 10
27
```

The `\x -> 2 * x + 7` expression is an anonymous function.

Anonymous functions can be "saved" with names:

```haskell
lenVec = \x -> \y -> sqrt $ x ^ 2 + y ^ 2

-- or
lenVec = \x y -> sqrt $ x ^ 2 + y ^ 2
```

### `on` with anonymous function

The following function accepts two pairs of pairs and returns a sum of first
elements of first pair:

```haskell
sumFstFst = (+) `on` helper where
  helper pp = fst (fst pp)
```

with anonymous function:

```haskell
sumFstFst = (+) `on` \pp -> fst (fst pp)
```

## Composition

```haskell
f :: b -> c
g :: a -> b

compose :: (b -> c) -> (a -> b) -> a -> c 
compose f g = \x -> f (g x)
```

Built-in composition operator is `.`:

```
GHCi> :t (.)
(.) :: (b -> c) -> (a -> b) -> a -> c
```

The previous function that returns a sum of first elements of first pair in pair
(`(1, True) sumFst (2, False)`) can be refactored in the following way:

```haskell
sumFst = (+) `on` (fst . fst)
```

## Data Structures Polymorphism

Lists and tuples are polymorphic:

```
GHCi> :t []
[] :: [a]

GHCi> :t (++)
(++) :: [a] -> [a] -> [a]

GHCi> :t (,)
(,) :: a -> b -> (a, b)

GHCi> :t fst
fst :: (a, b) -> a
```

`(,)` is a prefix syntax of tuple creation:

```haskell
pair = (,) 42 True

triple = (,,) 42 True "Answer"
```

## Currying

Currying is the technique of converting a function that takes multiple arguments
into a sequence of functions that each takes a single argument ([wiki](https://en.wikipedia.org/wiki/Currying)).

### `curry`

We can curry the `fst` function with the corresponding function `curry`:

```
GHCi> :type fst
fst :: (a, b) -> a

GHCi> :type curry fst
curry fst :: c -> b -> c 
```

In this example the `curry` function can be implemented like this:

```haskell
curry f x y = f (x, y)
```

### `uncurry`

```
GHCi> :t uncurry
uncurry :: (a -> b -> c) -> (a, b) -> c
```

```haskell
unc x y = x + y

sumOfPair = uncurry unc (1, 2) -- result: 3
```