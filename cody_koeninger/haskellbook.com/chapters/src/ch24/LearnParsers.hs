module LearnParsers where

import Text.Trifecta
import Text.Parser.Combinators

stop :: Parser a
stop = unexpected "stop"

one = char '1'

one' = one >> stop

oneEof = one >> eof

oneTwo = char '1' >> char '2'

oneTwo' = oneTwo >> stop

testParse :: Parser Char -> IO ()
testParse p =
  print $ parseString p mempty "123"

pNL s =
  putStrLn ('\n' : s)

oneTwoThree = oneTwo >> char '3'

myString :: String -> Parser String
myString "" = pure ""
myString (x:xs) = do
  c <- char x
  cs <- myString xs
  return $ c : cs

oneOrTwoOrThree = choice [try $ myString "123", try $ myString "12", try $ myString "1"]

pps p s = print $ parseString p mempty s

main = do
  pNL "one:"
  testParse one
  pps oneEof "1 "
  pps oneOrTwoOrThree "1"
  pps oneOrTwoOrThree "12"
  pps oneOrTwoOrThree "123"
