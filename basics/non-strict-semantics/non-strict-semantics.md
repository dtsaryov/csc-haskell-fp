# 2.5 Non-Strict Semantics

## Computation Order

Order of computation in imperative languages is defined by a sequence of
instructions. But in FP languages such instructions are absent -
all computations are just reductions.

Consider the following function:

```haskell
sumIt x y = x + y
```

and the `sumIt (1 + 2) 3` expression can be processed in two different ways: 

1. eager strategy:

```
sumIt (1 + 2) 3
~> sumIt 3 3
~> 3 + 3
~> 6
```

2. lazy strategy:

```
sumIt (1 + 2) 3
~> (1 + 2) + 3
~> 3 + 3
~> 6
```

### Redex - Reducible Expression

Consider the `sumIt (1 + 2) 3` expression - it has two redexes:

1. `1 + 2`
2. `sumIt` application

## Lazy Strategy Pros and Cons

### Pros

Consider a function:

```haskell
add7 x y = x + 7
```

In case of lazy strategy we will have the following reductions:

```
add7 1 (2 + 3)
~> 1 + 7
~> 8
```

The `2 + 3` expression is not reduced (not evaluated).

### Cons

Consider a function:

```haskell
dup x = (x, x)
```

In the following case an expression will be reduced twice:

```
dup (2 + 3)
~> ((2 + 3), (2 + 3))
~> (5, (2 + 3))
~> (5, 5)
```

### Evaluation Splitting

The problem described above is solved by evaluation splitting.

If the argument is used few times inside of function body, it is replaced by
a special reference that is used instead of it. After first expression
evaluation its result is reused in all others entries:

```
dup (2 + 3)
~> (p, p) -- p = 2 + 3 = 5
~> (5, p)
~> (5, 5)
```

## Non-Strict Functions Profit

Consider the function:

```haskell
const42 = const 42
```

This function always returns `42` regardless of the second argument:

```
GHCi> const42 True
42

GHCi> const42 undefined
42
```

## Normal Form

An expression that does not have any redexes (reducible expressions) is in
"normal form":

```
42
(2, 3)
\x -> x + 2
```

Expressions that are not in normal form:

```
"Real " ++ "World"
sin (pi / 2)
(\x -> x + 2) 5
(3, 1 + 5)
```

### Weak Head Normal Form

An expression is in WHNF when:

1. redex is inside of lambda: `\x -> x + 2 * 3`
2. data structure constructor: `(3, 1 + 5)`
3. partially applied data structure constructor: `(,) (2 * 3)`
4. partially applied built-in operator: `(+) (7 ^ 2)`

## Lazy Evaluation Forcing

To force an evaluation the `seq` function can be used:

```haskell
seq :: a -> b -> b
seq _|_ b = _|_
seq a b = b
```

The `seq` function tries to reduce the `a` argument. If `a` can be evaluated
`seq` returns `b`:

```
GHCi> seq 1 2
2

GHCi> seq undefined 2
*** Exception: Prelude.undefined
```

The `seq` function tries to check whether the `a` argument can be converted
to WHNF:

```
GHCi> seq (undefined, undefined) 42
42
```

### Calling a Function with Evaluated Argument

```haskell
($!) :: (a -> b) -> a -> b
($!) f x = x `seq` f x
```

The `$!` operator converts the `x` argument to WHNF and in case of success
calls `f`.

```
GHCi> const 42 $! undefined
*** Exception: Prelude.undefined
```

The previous implementation of `factorial` can be optimized:

```haskell
factorial :: Integer -> Integer
factorial n = helper 1 n where
  helper acc 0 = acc
  helper acc n = (helper $! (acc * n)) (n - 1)
```

But in the following case we will have delayed reductions due to WHNF
for the first argument and no delayed reductions due to pattern matching
for the second argument:

```haskell
mySum acc 0 = acc
-- '(result + n, ())' is a WHNF, so '$!' doesn't change anything
mySum (result, ()) n = (mySum $! (result + n, ())) $ n - 1 
```