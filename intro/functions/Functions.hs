module Functions where

-- function without args is a constant
helloWorld = "Hello World"

-- pure functions depend only args - the same result for the same args

pow2 x = x * x

sumPow2 x y = x ^ 2 + y ^ 2

lenVec3 x y z = sqrt (x ^ 2 + y ^ 2 + z ^ 2)

-- partial application

-- ternary function
translate languageTo languageFrom text = "Who is there?"

-- binary function
translateToRussian = translate "russian"

-- unary functions
translateFromSpanishToRussian = translateToRussian "spanish"

translateFromEnglishToRussian = translateToRussian "english"

-- conditional expression - returns a result
isAnswer x = if x == 42 then "yes" else "no"

sign x = if x > 0 then 1 else if x == 0 then 0 else -1

-- "real-world" example that uses partial application and conditional expression
discount limit proc sum = if sum >= limit then sum * (100 - proc) / 100 else sum

standardDiscount = discount 1000 5