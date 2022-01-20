module Identity where

{-
Consider type 'SomeType' that is an instance of Monad.

Make 'SomeType' to be instance of Functor

fmap :: Functor f => (a -> b) -> f a -> f b
return :: Monad m => a -> m a
(>>=) :: Monad m => m a -> (a -> m b) -> m b
-}
instance Functor SomeType where
  fmap f x = x >>= return . f