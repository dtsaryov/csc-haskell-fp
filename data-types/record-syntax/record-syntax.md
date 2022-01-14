# 4.3 Record Syntax

## Declaration

The trivial implementation of OOP-like object will be the following:

```haskell
data Person = Person String String Int

firstName (Person x _ _) = x
lastName (Person _ y _) = y
age (Person  _ z) = z
```

Haskell support a syntax to create such type in more convenient way:

```haskell
data Person = Person {
  firstName :: String,
  lastName :: String,
  age :: Int
} deriving (Show, Eq)

john = Person "John" "Snow" 27
xavier = Person {age = 40, firstName = "Phideaux", lastName = "Xavier"}
```

## Field Accessors

We are able to get a value from a field by function application:

```haskell
john = Person John Snow 27
fn = firstName john -- John
```

Another syntax is the `&` operator usage:

```haskell
x & f = f x

fn = john & firstName -- John
```

The `&` operator has left associativity.

## Modification

```haskell
updateAge :: Int -> Person -> Person
newPerson = updateAge newAge person = person {age = newAge} -- person is defined before
```