module Main where

import CodyHangman
import Test.QuickCheck
import Data.Maybe

genPuzzle :: Gen Puzzle
genPuzzle = do
  w <- (arbitrary :: Gen PrintableString)
  guessed <- arbitrary
  let word = (getPrintableString w)
  let success = map (\c -> if elem c guessed then Just c else Nothing) word
  return $ Puzzle word success guessed

instance Arbitrary Puzzle where
  arbitrary = genPuzzle

prop_fill :: Puzzle -> Char -> Bool
prop_fill p@(Puzzle w s g) c =
  let (Puzzle _ s' g') = fillInCharacter p c
      corrects xs = length $ filter isJust xs
  in
    (length g') >= (length g) &&
    if elem c w
    then (corrects s') >= (corrects s)
    else (corrects s') == (corrects s)

main :: IO ()
main = quickCheck prop_fill
