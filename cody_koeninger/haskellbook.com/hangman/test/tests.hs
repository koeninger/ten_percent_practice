module Main where

import CodyHangman
import Test.QuickCheck

bad :: Int -> Bool
bad x = 1 == 2

main :: IO ()
main = quickCheck bad