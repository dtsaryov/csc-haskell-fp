{-
*Main> main'
What is your name?
Name: John
Hi, John!
*Main> main'
What is your name?
Name:
What is your name?
-}
main' :: IO ()
main' = do
  putStrLn "What is your name?"
  putStr "Name: "
  name <- getLine
  if length name == 0 then main' else putStrLn $ "Hi, " ++ name ++ "!"