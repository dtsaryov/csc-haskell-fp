# 1.2 Functions

## Functional Programming Languages Computation Model

FP computation model is based on idea of sequential expression reduction:

```
(5 + 4 * 3) ^ 2
~> (5 + 12) ^ 2
~> 17 ^ 2
~> 289
```

## Function Call Syntax

```haskell
-- call a function `foo` with argument `bar`
foo bar

-- arc-cos of cos pi
acos (cos pi)
```

Reduction:
```
acos (cos pi)

~> acos (-1.0)
~> 3.14159...
```

Call a function with two Args:

```haskell
-- Call a function `f` with args: `x` and `y`
f x y

max 5 42
```

## Function Declaration

```haskell
-- no args
helloWorld = "Hello World"

-- single arg
pow2 x = x * x

-- two args
sumPow2 x y = x ^ 2 + y ^ 2
```

### Partial Application

```haskell
(max 5) 42 -- result: 42
```

Since the `max` function accepts two arguments, the `max 5` call returns
a partially applied function that waits for the second argument.

The partial application can be used to simplify declaration:

```haskell
-- returns a partially applied function
max5 = max 5

max5 4 -- returns 5

max5 42 -- returns 42
```

Partial application reduces function arity:
```haskell
-- ternary function
translate languageTo languageFrom text = "Who is there?"

-- binary function
translateToRussian = translate "russian"

-- unary functions
translateFromSpanishToRussian = translateToRussian "spanish"

translateFromEnglishToRussian = translateToRussian "english"
```

### Function Purity

Function that returns the same result for the same arguments called pure.

Corner case - function without arguments is a constant.

## Conditional Expression

Syntax: `if condition then true_result else false_result`

Example:

```haskell
isAnswer x = if x == 42 then "yes" else "no"

isAnswer 42 -- return "yes"
```

## Complex Example

Function `standardDiscount` is declared is partially applied `discount` function:

```haskell
discount limit proc sum = if sum >= limit then sum * (100 - proc) / 100 else sum

-- partially applied function
standardDiscount = discount 1000 5

-- return 1900
standardDiscount 2000
```