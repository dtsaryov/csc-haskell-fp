module TypeSynonyms where

import Data.Bits
import Data.Semigroup

newtype Xor = Xor { getXor :: Bool }
    deriving (Eq,Show)

instance Semigroup Xor where
    (Xor x) <> (Xor y) = Xor (x `xor` y)

instance Monoid Xor where
    mempty = Xor True
    mappend = (Data.Semigroup.<>)