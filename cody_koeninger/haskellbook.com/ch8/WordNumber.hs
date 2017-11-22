module WordNumber where

import Data.List (intersperse)

digitToWord :: Int -> String
digitToWord n =
    case n of
      0 -> "zero"
      1 -> "one"
      2 -> "two"
      3 -> "three"
      4 -> "four"
      5 -> "five"
      6 -> "six"
      7 -> "seven"
      8 -> "eight"
      9 -> "nine"

digits :: Int -> [Int]
digits n = reverse $ recur n
    where recur n =
              case quotRem n 10 of
                (0, r) -> [r]
                (q, r) -> r : recur q

wordNumber :: Int -> String
wordNumber = concat . intersperse "-" . (map digitToWord) . digits

