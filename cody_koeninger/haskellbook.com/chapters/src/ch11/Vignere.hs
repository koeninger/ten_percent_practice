module Vignere (Keyword, encode, decode) where

import Data.Char (toUpper, ord, chr)
import Test.QuickCheck

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

genAz :: Gen String
genAz = listOf1 $ elements ['A'..'Z']

newtype AZString = AZString String deriving (Eq, Show)

instance Arbitrary AZString where
  arbitrary = AZString <$> genAz

instance Arbitrary Keyword where
  arbitrary = Keyword <$> genAz

propRoundtrip :: Keyword -> AZString -> Bool
propRoundtrip k (AZString s) = s == (decode k (encode k s))

runChecks = do
  quickCheck propRoundtrip
