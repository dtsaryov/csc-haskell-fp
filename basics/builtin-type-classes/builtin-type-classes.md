# 2.4 Built-in Type Classes

## Class Extension

Base type class:

```haskell
class Eq a where
(==), (/=) :: a -> a -> Bool

x /= y = not (x == y)
x == y = not (x /= y) -- cyclic definition
```

The `Ord` class extends `Eq` class:

```haskell
class (Eq a) => Ord a where
  (<), (<=), (>=), (>) :: a -> a -> Bool
  max, min             :: a -> a -> a
  compare              :: a -> a -> Ordering
  -- minimal complete definition: either 'compare' or '<='
```

`Ordering`:

```
GHCi> :i Ordering

data Ordering = LT | EQ | GT
```

### Multiple Class Extension

`MyClass` extends `Eq` and `Printable`:

```haskell
class (Eq a, Printable a) => MyClass where
  -- ...
```

## `Show` Class

Types that belong to the `Show` class can be converted to `String`:

```
GHCi> :t show
show :: Show a => a -> String

GHCi> show 5
"5"
```

## `Read` Class

### `read`

The `read` function parses a `String` value and returns some typed value:

```
GHCi> :t read
read :: Read a => String -> a
```

This function has a polymorphic return type, so we have to specify target type:

```
GHCi> read "5" :: Int
5
```

### `reads`

When the input is complex the `reads` function can be used:

```
GHCi> reads "42 answer" :: [(Int, String)]
[(5, " answer") ]
```

It returns an empty list if nothing parsed.

## `Enum` Class

```haskell
class Enum where
  succ, pred :: a -> a
  toEnum     :: Int -> a
  fromEnum   :: a -> Int
```

```
GHCi> succ 4
5

GHCi> pred 'z'
y

GHCi> fromEnum 'z'
122

GHCi> toEnum 122 :: Char
'z'
```

## `Bounded` Class

```haskell
class Bounded where
  minBound, maxBound :: a
```

The `Bool` class belongs to `Bounded`:

```
GHCi> succ False
True

GHCi> succ True
*** Exception: Prelude.Enum.Bool.succ: bad argument

GHCi> minBound :: Bool
False

GHCi> naxBound :: Bool
True 
```

## `Num` Class

All number types belong to the `Num` class.

```haskell
class Num a where
  (+), (-), (*) :: a -> a -> a
  negate        :: a -> a
  abs           :: a -> a
  signum        :: a -> a
  fromInteger   :: Integer -> a
  
  x - y    = x + negate y
  negate x = 0 - x
```

`Integer` belongs to `Integral`:

```haskell
type Integral :: * -> Constraint
class (Real a, Enum a) => Integral a where
  quot :: a -> a -> a
  rem :: a -> a -> a
  div :: a -> a -> a
  mod :: a -> a -> a
  quotRem :: a -> a -> (a, a)
  divMod :: a -> a -> (a, a)
  toInteger :: a -> Integer
  {-# MINIMAL quotRem, toInteger #-}
```

`Fractional`:

```haskell
type Fractional :: * -> Constraint
class Num a => Fractional a where
  (/) :: a -> a -> a
  recip :: a -> a
  fromRational :: Rational -> a
  {-# MINIMAL fromRational, (recip | (/)) #-}
```