module Addition where

    import Test.Hspec
    
    main :: IO ()
    main = hspec $ do
                  describe "Addition" $ do
                     it "15 divided by 3 is 5" $ do
                                          dividedBy (15 :: Integer) 3 `shouldBe` (5, 0)
                     it "22 divided by 5 is 4 rem 2" $ do
                                          dividedBy (22 :: Integer) 5 `shouldBe` (4, 2)
                     it "3 mult -4 is -12" $ do
                                          mult 3 (-4 :: Integer) `shouldBe` 12

    dividedBy :: Integral a => a -> a -> (a, a)
    dividedBy num denom = recur num denom 0
        where recur n d c
                  | n < d = (c, n)
                  | otherwise =
                      recur (n - d) d (c + 1)

    mult :: (Eq a, Num a, Ord a) => a -> a -> a
    mult x y = recur (abs y)
        where recur 0 = 0
              recur c = x + recur (c - 1)

                          
