# The Haskell Language - Quick Reference

Language Haskell is a pure functional programming language with lazy execution
semantic and polymorphic static typing. The language is named after
the American logician and mathematician Haskell Brooks Curry.

## Resources:

- [haskell.org](https://www.haskell.org/) - Haskell "home page"
- [Hoogle](https://www.haskell.org/hoogle/) - Haskell "Google"
- [Haskell 2010](https://www.haskell.org/onlinereport/haskell2010/) - current lang standard

# Basic Haskell Dev Environment

Few tools from the Haskell Platform will be used:

1. Glasgow Haskell Compiler (GHC)
2. GHC’s interactive environment (GHCi)

Source files are text files with the `*.hs` extension.

## Haskell Interpreter Usage

```
> ghci

Prelude> 33 + 3 * 3
42
```

Change prompt:
```
> ghci

Prelude> :set prompt "GHCi> "
GHCi> 33 + 3 *3
42
```

### Run Interpreter with Module

`ghci Hello.hs`

### Load Module from Interpreter

`GHCi> :load Hello.hs`

or

`GHCi> :l Hello.hs`

### Reload Module

To reload a module the `:reload` command can be used.

The `:load` command also may be used.