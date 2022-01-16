# 4.5 Recursive Types

Recursive types contains themselves inside of data constructors:

```haskell
Foo a = Foo a Foo a
```

List is a recursive type:

```haskell
data List a = Nil | Cons a (List a)

emptyList = Nil -- Nil :: List a
singletonList = Cons 42 Nil -- Cons 42 Nil :: List Int
```