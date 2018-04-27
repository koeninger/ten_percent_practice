{-# LANGUAGE OverloadedStrings #-}

module Text.Fractions where

import Control.Applicative
import Data.Ratio ((%))
import Text.Trifecta

badFraction = "1/0"
alsoBad = "10"
shouldWork = "1/2"
shouldAlsoWork = "2/1"

parseFraction :: Parser Rational
parseFraction = do
  numerator <- decimal
  char '/'
  denominator <- decimal
  case denominator of
    0 -> fail "Denominator can't be zero"
    _ -> return (numerator % denominator)

integerEof = do
  it <- integer
  e <- eof
  return it
      
main :: IO ()
main = do
  let ppf s = print $ parseString parseFraction mempty s
  ppf shouldWork
  ppf shouldAlsoWork
  ppf alsoBad
  ppf badFraction
  print $ parseString integerEof mempty "123"
  print $ parseString integerEof mempty "123asd"
