import Control.Monad
import System.Exit (exitSuccess)
import Data.Char (isAlpha, toLower)
    
palindrome :: IO ()
palindrome = forever $ do
               line1 <- getLine
               case (isPalindrome line1) of
                 True -> putStrLn "palindrome!"
                 False -> do
                     putStrLn "nope!"
                     exitSuccess

isPalindrome :: [Char] -> Bool
isPalindrome xs = alpha == reverse alpha
    where alpha = fmap toLower $ filter isAlpha xs


type Name = String
type Age = Integer

data Person = Person Name Age deriving Show

data PersonInvalid = NameEmpty
                   | AgeTooLow
                   | PersonInvalidUnknown String
                   deriving (Eq, Show)

mkPerson :: Name
            -> Age
            -> Either PersonInvalid Person
mkPerson name age
    | name /= "" && age > 0 =
        Right $ Person name age
    | name == "" =
        Left NameEmpty
    | not (age > 0) =
        Left AgeTooLow
    | otherwise =
        Left $ PersonInvalidUnknown $
                 "name: " ++ show name ++ " age: " ++ show age


gimmePerson :: IO ()
gimmePerson = do
  putStrLn "name?"
  name <- getLine
  putStrLn "age?"
  age <- getLine
  case mkPerson name (read age) of
    Right p -> putStrLn $ "yay! " ++ show p
    Left e -> putStrLn $ "nope! " ++ show e
