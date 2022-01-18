module Functor where

import Data.Char

{-
GHCi> fmap (+ 1) (Point3D 5 6 7)
Point3D 6 7 8
-}
data Point3D a = Point3D a a a deriving Show

instance Functor Point3D where
  fmap f (Point3D x y z) = Point3D (f x) (f y) (f z)

{-
Point (Point3D 1 1 1)

GHCi> fmap (+ 1) $ LineSegment (Point3D 0 0 0) (Point3D 1 1 1)
LineSegment (Point3D 1 1 1) (Point3D 2 2 2)
-}
data GeomPrimitive a = Point (Point3D a) | LineSegment (Point3D a) (Point3D a) deriving Show

instance Functor GeomPrimitive where
    fmap f (Point p) = Point (fmap f p)
    fmap f (LineSegment p1 p2) = LineSegment (fmap f p1) (fmap f p2)

{-
GHCi> words <$> Leaf Nothing
Leaf Nothing

GHCi> words <$> Leaf (Just "a b")
Leaf (Just ["a","b"])
-}
data Tree a = Leaf (Maybe a) | Branch (Tree a) (Maybe a) (Tree a) deriving Show

instance Functor Tree where
  fmap f (Leaf x) = Leaf $ fmap f x
  fmap f (Branch l x r) = Branch (fmap f l) (fmap f x) (fmap f r)

{-
GHCi> fmap (map toUpper) $ Map []
Map []

GHCi> fmap (map toUpper) $ Map [Entry (0, 0) "origin", Entry (800, 0) "right corner"]
Map [Entry (0,0) "ORIGIN",Entry (800,0) "RIGHT CORNER"]
-}
data Entry k1 k2 v = Entry (k1, k2) v  deriving Show
data Map k1 k2 v = Map [Entry k1 k2 v]  deriving Show

instance Functor (Entry k1 k2) where
    fmap f (Entry p v) = Entry p (f v)

instance Functor (Map k1 k2) where
    fmap f (Map ks) = Map $ map (fmap f) ks