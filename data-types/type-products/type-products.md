# 4.2 Type Products

## Declaration

Consider the following declaration:

```haskell
data Point = Pt Double Double
```

where:

1. `data Point` - type constructor
2. `Pt Double Double` - data constructor

The `origin` function can be implemented like this:

```haskell
origin :: Point
origin = Pt 0.0 0.0
```

and `distanceToOrigin`:

```haskell
distanceToOrigin :: Point -> Double
distanceToOrigin (Pt x y) = sqrt (x ^ 2 + y ^ 2)
```

## Constructor Functions

Consider the next example:

```haskell
data Shape = Circle Double | Rectangle Double Double
  deriving Show
```

We can declare the `square` function that can be used as a constructor:

```haskell
square :: Double -> Shape
square a = Rectangle a a

mySquare = square 42 -- returns Rectangle 42 42
```

## Lazy Pattern Matching

```haskell
fromMaybe ~(Just x) = x
```

`~` is used to specify pattern as lazy to postpone x evaluation:

```haskell
alwaysOne :: Bool -> Int
alwaysOne ~True = 1
alwaysOne False = 0
  
one = alwaysOne False -- result: 1
```