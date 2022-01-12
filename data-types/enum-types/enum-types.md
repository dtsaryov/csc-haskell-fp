# 4.1 Enum Types

Data type declaration:

```haskell
data Bool = False | True
```

where:

1. `data Bool` - type constructor
2. `False | True` - data constructors

```haskell
alwaysTrue :: Int -> Bool -- type constructor is used
alwaysTrue n = True -- data constructor is used
```

## Custom Types and Pattern Matching

Consider the following type:

```haskell
data B = F | T

not' b :: B -> B
not' F = T
not' T = F
```

## Deriving

The deriving mechanism enables to automatically add behavior from some types:

```haskell
-- functions from these types will be available
data B = F | T deriving (Eq, Enum, Show, Read)
```

## `case..of`

Similar to the `switch` operator from imperative languages, but uses pattern
matching:

```haskell
instance Show Color where
    show color = case color of Red   -> "Red"
                               Green -> "Green"
                               Blue  -> "Blue"
```