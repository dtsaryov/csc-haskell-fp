# 1.4 Basic Types

1. Char
2. Bool
3. Int
4. Integer
5. Float
6. Double

## Expression Type Check

Terminal:
```
GHCi> :type 'c'
'c' :: Char

GHCi> :t 'c'
'c' :: Char

GHCi> :t False
False :: Bool

GHCi> :t 3
3 :: Num p => p
```

## Tuples

```haskell
(2, True)

(2, True, 'c')
```

### Util Functions

Get the first element of a tuple:

```haskell
fst (2, True) -- result: 2
```

Get the second element of a tuple:

```haskell
snd (2, True) -- result: True
```

## Lists

Declaration:
```haskell
[1, 2, 3]

[True, False]
```

`Char` list is a `String`:
```
GHCi> :t ['H','i']
['H','i'] :: [Char]

GHCi> :t "Hi"
"Hi" :: [Char]

GHCi> ['H','i']
"Hi"
```

### Concatenation

Add an element as a list head:

```haskell
1 : [2, 3] -- result: [1, 2, 3]
```

Concat lists:

```haskell
[1] ++ [2, 3] -- result: [1, 2, 3]
```