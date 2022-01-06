module NonStrictSemantics where

-- consider the following definitions:
id x = x
const' x y = x
max x y = if x <= y then y else x
infixr 0 $
f $ x = f x
{-
how many redexes in the next expression?

const $ const (4 + 5) $ max 42

1. $
2. $
3. +
-}

-- consider the following definitions
bar x y z = x + y
foo a b = bar a a (a + b)
value = foo (3 * 10) (5 - 2)

{-
how many reductions are required to eval 'value'

1. ~> bar (3 * 10) (3 * 10) ((3 * 10) + (5 - 2))
2. ~> (3 * 10) + (3 * 10)
3. ~> 30 + 30
4. ~> 60
-}

-- which functions are can evaluated regardless of the arguments:
foo' a = a                            -- foo' undefined
bar' = const foo                      -- bar' undefined
baz x = const True                    -- ok
quux = let x = x in x                 -- quux undefined
corge = "Sorry, my value was changed" -- ok
grault x 0 = x                        -- grault undefined 0
grault x y = x                        -- grault undefined undefined
garply = grault 'q'                   -- gaprply undefined - 'undefined' is compared to '0'
waldo = foo                           -- waldo undefined

-- Which expressions are in WHNF:
id' = \x -> x                    -- NF - lambda without redexes
pairFst =  fst (1,0)             -- NNF
notCompletedPair = (,) undefined -- WHNF - data structure constructor
list' = [undefined, 4 + 5, -1]   -- WHNF - data structure constructor
three = 3                        -- NF - just a constant
plusSection = (+) (2 * 3 * 4)    -- WHNF - partially applied built-in operator

{-
in which cases the 'seq' function prevents not reduced redexes amount growth
-}

-- doesn't prevent - x' `seq` x' can be replaced by x'
foo'' 0 x = x
foo'' n x = let x' = foo'' (n - 1) (x + 1)
            in x' `seq` x'

-- doesn't prevent since f' is a lambda
bar'' 0 f = f
bar'' x f = let f' = \a -> f (x + a)
                x' = x - 1
            in f' `seq` x' `seq` bar'' x' f'

-- doesn't prevent since p - pair construction
baz'' 0 (x, y) = x + y
baz'' n (x, y) = let x' = x + 1
                     y' = y - 1
                     p  = (x', y')
                     n' = n - 1
                 in p `seq` n' `seq` baz'' n' p

-- prevents
quux'' 0 (x, y) = x + y
quux''' n (x, y) = let x' = x + 1
                       y' = y - 1
                       p  = (x', y')
                       n' = n - 1
                   in x' `seq` y' `seq` n' `seq` quux'' n' p