# 4.4 Parameterized Types

Consider the following "hardcoded" types:

```haskell
data CoordD = CoordD Double Double

data CoordI = CoordI Int Int
```

The generic solution is to use parameterized type:

```haskell
data Coord a = Coord a a
```

## Kinds

Kinds are "supertypes" of types:

```
GHCi> :k Char
Char :: *

GHCi> :k Maybe
Maybe :: * -> *

GHCi> :k Maybe Int
Maybe Int :: *
```

## Forcing in Constructors

To force arg evaluation we should use the `!` operator:

```haskell
data Foo a = Foo !a !a
```

In this case expressions passed as arguments will be evaluated:

```haskell
data FooLazy a Foo a a

getXLazy (FooLazy x _) = x
getX (Foo x _) = x
  
lazy = getXLazy $ FooLazy 42 undefined -- result: 42
forced = getX $ Foo 42 undefined -- error
```