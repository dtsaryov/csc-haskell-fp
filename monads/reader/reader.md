# 5.6 Reader

## Functor and Monad Instances

```haskell
instance Functor ((->) e) where
  fmap g h = g . h

fmap :: (a -> b) -> f a -> f b
fmap :: (a -> b) -> (e -> a) -> (e -> b)

lengthSquare = fmap (^2) length [1,2,3] -- result: 9

instance Monad ((->) e) where
  return :: a -> (e -> a)
  return x = \_ -> x

  m >>= k = \e -> k (m e) e
```

## Definition

```haskell
newtype Reader r a = Reader { runReader :: (r -> a) }

instance Monad (Reader r) where
  return x = Reader $ \e -> x
  m >>= k = Reader $ \e ->
    let v = runReader m e
    in runReader (k v) e
```

## Example

```haskell
type User = String
type Password = String
type UsersTable = [(User, Password)]

ask :: Reader r r
ask = Reader id

passwords :: UsersTable
passwords = [("Bill", "123"), ("...", "...")]

firstUser = do
  e <- ask
  return $ fst (head e)
```