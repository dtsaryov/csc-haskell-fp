# 1.3 Operators

## Notations

### Infix notation

All binary operators are used in infix notation:

```haskell
42 + 3

4 - 7
```

To call a binary function in infix notation we can wrap it into backticks:

````haskell
3 `max` 7
````

### Prefix Notation

Functions are called in prefix notation:

```haskell
foo bar baz
```

To use an operator with prefix notation it should be wrapped into parentheses:

```haskell
(+) 7 3

(-) 2 5
```

## Priority and Associativity

### Priority

All operators have a priority (from 0 to 9 - higher is more important).
Operators with higher priority are applied before operators with lower priority:

```haskell
3 + 5 * 8 -- result: 43

sin 5 + 4 -- result: 3.0410757...
```

### Associativity

Depending on associativity type an expression `3 - 5 - 9` can be evaluated
in two different ways:

1. `(3 - 5) - 9` - result: `-11`, left associativity
2. `3 - (5 - 9)` - result: `-1`, right associativity

This expression is evaluated to `-11` in Haskell due to left associativity
of operators.

#### Set Operator Associativity

Syntax:

`infix[l/r] priority operators`

Example:

```haskell
-- set right associativity and 8 priority for '^' and 'logBase'
infixr 8 ^,`logBase`

-- set left associativity and 6 priority for '+' and '-'
infixl 6 +,-

-- do not set any associativity and 4 priority for '=='
infix 4 ==

2 * (1 + 4) ^ 2
```

## Define a Custom Operator

The following chars can be used to build a combination that will represent
a new operator:

`! # $ % & * + . / < = > ? @ \ ^ | - ~`

Specify operator associativity and priority:

```haskell
infixl 6 *+*
```

Define the operator:

```haskell
a *+* b = a ^ 2 + b ^ 2

3 *+* 4   -- result: 25

(*+*) 3 4 -- result: 25
```

The operator can be also declared in prefix notation:

```haskell
*+* a b = a ^ 2 + b ^ 2
```

## Sections

Section is a partial application of operator:

```haskell
divBy2 = (/ 2)
 
divBy2 8 -- result: 4
```

Parentheses are required.

## Priority Reduction

The `$` operator can be used to make operator priority lower:

```haskell
-- have to use parentheses
sin (pi / 2)

-- can omit parentheses
sin $ pi / 2
```

The `$` has the lowest priority and right-associativity that is useful
in complex expressions to omit parentheses.

```haskell
-- have to use parentheses
logBase 4 (min 20 (9 + 7))

-- can omit
logBase 4 $ min 20 $ 9 + 7
```