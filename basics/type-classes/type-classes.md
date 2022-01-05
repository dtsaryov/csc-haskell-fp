# 2.3 Type Classes

Type class is as a kind of interface the type belongs to.
For example `Integer` belongs to the `Integral` class, and the `Integral` class
is a part of the `Num` class:

```
GHCi> :t 42
7 :: Num p => p
```

A type is an instance of some class if it belongs to this class.

Operators and functions can be polymorphic, but some type class can be
specified:

```
GHCI> :t (<)
(<) :: Ord a => a -> a -> Bool

GHCI> :t (< 5)
(< 5) :: (Ord a, Num a) => a -> Bool 
```

For the partially applied operator we have two restrictions for an argument:
1. it should belong to the `Ord` class
2. it should belong to the `Num` class

For example, imaginary numbers belong to the `Num` class, but do not belong to the `Ord` class.

Syntax `(...) => args -> result` describes a context of a function.

## Type Class Declaration

```haskell
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
```

## Type Class Instance Declaration

```haskell
class Eq a where
  (==), (/=) :: a -> a -> Bool

instance Eq Bool where
  True  == True  = True
  False == False = True
  _     == _     = False -- '_' means like 'otherwise'
  x     /= y     = not (x == y)
```

## Default Implementation

Default implementation of some function or operator can be described inside of type class:

```haskell
class Eq a where
  (==), (/=) :: a -> a -> Bool
  x     /= y     = not (x == y) -- default implementation

instance Eq Bool where
  True  == True  = True
  False == False = True
  _     == _     = False
```

## Type Classes and Polymorphism

We can also declare any polymorphic type as a type class:

```haskell
instance (Eq a, Eq b) => Eq (a, b) where
  p1 == p2 = fst p1 == fst p2 && snd p1 == snd p2
```

`(Eq a, Eq b) => Eq (a, b)` is a context that means that:

1. we can compare only pairs that belong to the  `Eq` class
2. a pair belong to the `Eq` class when its both elements belong to the `Eq` class

The same for lists:

```haskell
instance Eq a => Eq [a] where
  x == y = undefined -- implementation omitted
```