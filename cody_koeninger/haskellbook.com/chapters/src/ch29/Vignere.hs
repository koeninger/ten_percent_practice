--module Vignere (Keyword, encode, decode) where

import Data.Char (toUpper, ord, chr)
import Control.Monad (forever)
import qualified System.IO as SIO
import qualified System.Environment as SE
       
newtype Keyword = Keyword String deriving (Eq, Show)

start = ord 'A'

shift :: (Char, Int) -> Char
shift (c, n)
  | (ord c < start || ord c >= start + 26) = c
  | otherwise = chr $ start + mod ((ord c - start) + n) 26

unshift :: (Char, Int) -> Char
unshift (c, n) = shift (c, -n)

pairs :: Keyword -> String -> [(Char, Int)]
pairs (Keyword k) s =
  let
    ku = map toUpper k
    su = map toUpper s
    shifts = map (\c -> ord c - start) ku
  in zip su $ cycle shifts
                               
encode :: Keyword -> String -> String
encode kw s =
  map shift $ pairs kw s
                 
decode :: Keyword -> String -> String
decode kw s =
  map unshift $ pairs kw s

main :: IO ()
main = do
  args <- SE.getArgs
  input <- SIO.hGetContents SIO.stdin
  SIO.hPutStr SIO.stdout $
    case args of
      (key : "-d" : []) ->
        decode (Keyword key) input
      (key : "-e" : []) ->
        encode (Keyword key) input
      _ ->
        "Usage:\nVignere somekeyword <-d to decode | -e to encode>\n"
