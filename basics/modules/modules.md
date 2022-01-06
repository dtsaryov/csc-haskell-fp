# 2.6 Modules

The main file should be named `Main.hs` and contain the `Main` module:

```haskell
module Main where

-- declarations
```

All other modules should be declared in a file with the corresponding name.

## Module Import

By default, the `Prelude` module is imported. To import any other module
the `import` directive should be used:

```haskell
import Data.Char
```

### Specific Import

```haskell
import Data.Char (toUpper) -- imports only toUpper function
import Data.Char (toUpper, toLower) -- imports toUpper and toLower functions
import Data.Char hiding (toLower) -- imports everything from Data.Char except toLower
```

### Qualified Import

Consider the case:

```haskell
import Data.List
import Data.Set
```

Now we have two functions with the same name `union` in the scope:

```haskell
GHCi> :t union
Ambiguous occurrence error
```

In this situation we can declare `Data.Set` import as qualified:

```haskell
import qualified Data.Set
```

Now all function from `Data.Set` have to be used with qualified name:
`Data.Set.union`

### Module Alias

```haskell
import qualified Data.Set as Set
```

```
GHCi> :t Set.union
```

## Module Hierarchy

To create a module `ModuleB` that is imported as `Modules.ModuleB` it should be
located inside of `Modules` directory.

## Module Exports

The following module exports only `sumIt` function:

```haskell
module Test (sumIt) where
  
sumIt x y = x + y

const42 = const 42
```

## Compilation Steps

1. syntax parsing - changing all references to qualified
2. type checking 
3. "unsugaring" - translating the source code to the `Core` language
4. optimizations
5. code generation
   1. convert to `STG`
   2. convert to `C--`