module Reader where

import Control.Monad (liftM, ap)

data Reader r a = Reader { runReader :: (r -> a) }

instance Functor (Reader r) where
    fmap = liftM

instance Applicative (Reader r) where
    pure  = return
    (<*>) = ap

instance Monad (Reader r) where
  return x = Reader $ \_ -> x
  m >>= k  = Reader $ \r -> runReader (k (runReader m r)) r

local' :: (r -> r') -> Reader r' a -> Reader r a
local' f m = Reader $ \e -> runReader m (f e)

{-
GHCi> runReader usersWithBadPasswords [("user", "123456"), ("x", "hi"), ("root", "123456")]
["user","root"]
-}
type User = String
type Password = String
type UsersTable = [(User, Password)]

asks = Reader

usersWithBadPasswords :: Reader UsersTable [User]
usersWithBadPasswords = asks (\users -> map fst $ filter ((== "123456") . snd) users)