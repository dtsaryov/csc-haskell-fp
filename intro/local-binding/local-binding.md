# 1.6 Local Binding and Indentation

## Indentation

Declaration parts that are placed in separate lines should have non-zero
indentation:

```haskell
roots :: Double -> Double -> Double
        -> (Double, Double)
        
roots a b c =
  (
    (-b - sqrt (b ^ 2 - 4 * a * c)) / (2 * a)
  ,
    (-b + sqrt (b ^ 2 - 4 * a * c)) / (2 * a)
  )
```

## Local Binding

### `let .. in`

To simplify the previous declaration we can use the `let ... in` expression:

```haskell
roots a b c =
  let d = sqrt (b ^ 2 - 4 * a * c) in
  (
    (-b - d) / (2 * a)
  ,
    (-b + d) / (2 * a)
  )
```

Local binding can be used to declare multiple expressions:

```haskell
roots a b c =
  let {
    d = sqrt (b ^ 2 - 4 * a * c);
    x1 = (-b - d) / (2 * a);
    x2 = (-b + d) / (2 * a)} in
  (x1, x2)
```

or without curly braces:

```haskell
roots a b c =
  let
    d = sqrt (b ^ 2 - 4 * a * c)
    x1 = (-b - d) / (2 * a)
    x2 = (-b + d) / (2 * a)
  in (x1, x2)
```

#### Local Functions

Optimized factorial function can be refactored in the following way:

```haskell
factorial n
  | n >= 0 = let
      helper acc 0 = acc
      helper acc n = helper (acc * n) (n - 1)
    in helper 1 n
  | otherwise = error "n must be >= 0"
```

#### Destructuring with Local Binding

```haskell
rootsDiff a b c = let
  (x1, x2) = roots a b c
  in x2 - x1
```

### `where`

```haskell
roots a b c = (x1, x2) where
  d = sqrt (b ^ 2 - 4 * a * c)
  x1 = (-b - d) / (2 * a)
  x2 = (-b + d) / (2 * a)
```

```haskell
factorial n
  | n >= 0 = helper 1 n
  | otherwise = error "n must be >= 0"
  where
    helper acc 0 = acc
    helper acc n = helper (acc * n) (n - 1)
```