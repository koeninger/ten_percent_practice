module Addition where

import Test.Hspec
import Test.QuickCheck
    
main :: IO ()
main = hspec $ do
  describe "Addition" $ do
    it "15 divided by 3 is 5" $ do
      dividedBy (15 :: Integer) 3 `shouldBe` (5, 0)
    it "22 divided by 5 is 4 rem 2" $ do
      dividedBy (22 :: Integer) 5 `shouldBe` (4, 2)
    it "3 mult -4 is -12" $ do
      mult 3 (-4 :: Integer) `shouldBe` 12
    it "x + 1 is always greater than x" $ do
      property $ \x -> x + 1 > (x :: Int)

dividedBy :: Integral a => a -> a -> (a, a)
dividedBy num denom = recur num denom 0
  where
    recur n d c
      | n < d = (c, n)
      | otherwise =
        recur (n - d) d (c + 1)

mult :: (Eq a, Num a, Ord a) => a -> a -> a
mult x y = recur (abs y)
  where
    recur 0 = 0
    recur c = x + recur (c - 1)

trivialInt :: Gen Int
trivialInt = return 1

oneThroughThree :: Gen Int
oneThroughThree = elements [1, 2, 2, 2, 2, 2, 2, 3]

genBool :: Gen Bool
genBool = choose (False, True)

genBool' :: Gen Bool
genBool' = elements [False, True]

genOrdering :: Gen Ordering
genOrdering = elements [LT, EQ, GT]

genChar :: Gen Char
genChar = elements ['a'..'z']

genTuple :: (Arbitrary a, Arbitrary b) => Gen (a, b)
genTuple = do
  a <- arbitrary
  b <- arbitrary
  return (a, b)

genEither :: (Arbitrary a, Arbitrary b) => Gen (Either a b)
genEither = do
  a <- arbitrary
  b <- arbitrary
  elements [Left a, Right b]

genMaybe :: Arbitrary a => Gen (Maybe a)
genMaybe = do
  a <- arbitrary
  elements [Nothing, Just a]

genMaybe' :: Arbitrary a => Gen (Maybe a)
genMaybe' = do
  a <- arbitrary
  frequency [ (1, return Nothing)
            , (3, return (Just a))]

prop_additionGreater :: Int -> Bool
prop_additionGreater x = x + 1 > x

runQc :: IO ()
runQc = quickCheck prop_additionGreater
