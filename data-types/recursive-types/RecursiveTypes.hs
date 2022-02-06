module RecursiveTypes where

data List a = Nil | Cons a (List a) deriving Show

{-
> fromList $ Cons 1 (Cons 2 (Cons 3 (Cons 4 (Cons 5 Nil))))
[1,2,3,4,5]
-}
fromList :: List a -> [a]
fromList Nil = []
fromList (Cons x xs) = x : (fromList xs)

{-
> toList [1,2,3,4,5]
Cons 1 (Cons 2 (Cons 3 (Cons 4 (Cons 5 Nil))))
-}
toList :: [a] -> List a
toList [] = Nil
toList (x:xs) = Cons x (toList xs)

------

data Nat = Zero | Suc Nat deriving Show

fromNat :: Nat -> Integer
fromNat Zero = 0
fromNat (Suc n) = fromNat n + 1

toNat :: Integer -> Nat
toNat 0 = Zero
toNat n = Suc (toNat $ n - 1)

factorial n
  | n >= 0 = let
      helper acc 0 = acc
      helper acc n = helper (acc * n) (n - 1)
    in helper 1 n
  | otherwise = error "n must be >= 0"

add :: Nat -> Nat -> Nat
add x y = toNat $ (fromNat x) + (fromNat y)

mul :: Nat -> Nat -> Nat
mul x y = toNat $ (fromNat x) * (fromNat y)

fac :: Nat -> Nat
fac x = toNat . factorial $ fromNat x

------

data Tree a = Leaf a | Node (Tree a) (Tree a)

height :: Tree a -> Int
height (Leaf _) = 0
height (Node l r) = max (1 + height l) (1 + height r)

size :: Tree a -> Int
size (Leaf _) = 1
size (Node l r) = 1 + (size l) + (size r)

avg :: Tree Int -> Int
avg t =
    let (c,s) = go t
    in s `div` c
  where
    go :: Tree Int -> (Int,Int)
    go (Leaf x) = (1, x)
    go (Node l r) = (lc + rc, ls + rs) where
      (lc, ls) = go l
      (rc, rs) = go r

------

{-
NOT SOLVED

v1 * (v2 + v3) * v4 = v1 * v2 * v4 + v1 * v3 * v4
-}
infixl 6 :+:
infixl 7 :*:
data Expr = Val Int | Expr :+: Expr | Expr :*: Expr
    deriving (Show, Eq)

expand :: Expr -> Expr
expand ((e1 :+: e2) :*: e) =
  expand (expand e1 :*: expand e) :+:
  expand (expand e2 :*: expand e)
expand (e :*: (e1 :+: e2)) =
  expand (expand e :*: expand e1) :+:
  expand (expand e :*: expand e2)
expand (e1 :+: e2) = expand e1 :+: expand e2
expand (e1 :*: e2) = let
    ee1 = expand e1
    ee2 = expand e2
  in if ee1 == e1 && ee2 == e2 then e1 :*: e2 else expand $ ee1 :*: ee2
expand e = e