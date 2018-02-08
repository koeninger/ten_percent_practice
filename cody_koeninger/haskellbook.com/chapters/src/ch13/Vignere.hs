module Vignere (Keyword, encode, decode) where

    import Data.Char (toUpper, ord, chr)
        
    newtype Keyword = Keyword String deriving (Eq, Show)

    start = ord 'A'

    shift :: (Char, Int) -> Char
    shift (c, n) = chr $ start + mod ((ord c - start) + n) 26

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


    userInput :: IO (String)
    userInput = do
      putStrLn "keyword?"
      k <- getLine
      putStrLn "string?"
      s <- getLine
      putStrLn "[e]ncode or [d]ecode?"
      cmd <- getLine
      return $ case cmd of
        ['e'] -> encode (Keyword k) s
        ['d'] -> decode (Keyword k) s
        _ -> "you didn't follow instructions"

