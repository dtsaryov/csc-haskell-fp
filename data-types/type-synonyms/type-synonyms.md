# 4.6 Type Synonyms

`String` is a synonym for `[Char]`:

```haskell
type String = [Char]

allUpper :: String -> Bool
allUpper = all isUpper
```

## `newtype`

Types created with `newtype` are dev-time aliases that will be unwrapped
at runtime.

Such declarations should have only one argument in constructor:

```haskell
newtype A a b = A a
-- or
newtype A = A
```

## Monoid

```haskell
class Monoid a where
  mempty :: a            -- neutral element
  mappend :: a -> a -> a -- operation
  
  mconcat :: [a] -> a    -- fold
  mconcat = foldr mappend mempty
```

Laws:

1. `mempty 'mappend' x = x`
2. `x 'mappend' mempty = x`
3. `(x 'mappend' y) 'mappend z = x 'mappend' (y 'mappend' z)`

Monoid instance for lists:

```haskell
instance Monoid [a] where
  mempty = []
  mappend = (++)
```