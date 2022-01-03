# 1.5 Recursion

Recursion in FP can be used to implement loops:

```haskell
factorial n = if n == 0 then 1 else n * factorial (n - 1)
```

## Recursive Function Restrictions

1. recursive call should have different args (for example, `factorial n` and `factorial (n - 1)`)
2. terminating case should present (for example, `if n == 0 then 1`)

## Pattern Matching

Pattern matching can be used instead of the `if` expression to implement
recursion:

```haskell
factorial 0 = 1
factorial n = n * factorial (n - 1)
```

## Guards

```haskell
factorial n | n == 0     = 1 
            | n > 0      = n * factorial (n - 1)
            | otherwise  = error "n must be >= 0"
```

## Throwing Errors

```haskell
error "error message"

undefined
```

Usage example:

```haskell
factorial 0 = 1
factorial n = if n < 0 then error "n must be >= 0" else n * factorial (n - 1)
```

## Optimization

Recursive functions can be optimized using an accumulator.

Let's compare default fibonacci sequence generation algorithm and a version
with accumulator:

```haskell
-- default
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)

-- optimized
fibonacciAcc n = fibOpt 0 1 n

fibOpt n1 n2 n | n == 0    = 0
               | n == 1    = n2
               | otherwise = fibOpt n2 (n1 + n2) (n - 1)
```

Compare performance with `:set +s`:
```
GHCi> fibonacci 30
832040
(1.96 secs, 921,593,208 bytes)

GHCi> fibonacciAcc 30
(0.00 secs, 90,064 bytes)
```