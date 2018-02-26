import Test.QuickCheck
import Test.QuickCheck.Gen (oneof)
import Data.List (sort)
import Data.Char (toUpper)


half :: Double -> Double
half x = x / 2

halfIdentity = (*2) . half

prop_halfIdentity x = halfIdentity x == x

listOrdered :: (Ord a) => [a] -> Bool
listOrdered xs =
  snd $ foldr go (Nothing, True) xs
  where go _ status@(_, False) = status
        go y (Nothing, t) = (Just y, t)
        go y (Just x, t) = (Just y, x >= y)

prop_listOrdered :: [Int] -> Bool
prop_listOrdered xs = listOrdered $ sort xs

plusAssociative :: Int -> Int -> Int -> Bool
plusAssociative x y z = x + (y + z) == (x + y) + z

plusCommutative :: Int -> Int -> Bool
plusCommutative x y = x + y == y + x

multAssociative :: Int -> Int -> Int -> Bool
multAssociative x y z = x * (y * z) == (x * y) * z

multCommutative :: Int -> Int -> Bool
multCommutative x y = x * y == y * x

prop_quoteRem :: NonZero Int -> NonZero Int -> Bool
prop_quoteRem (NonZero x) (NonZero y) = (quot x y) * y + (rem x y) == x

prop_divMod :: (NonZero Int) -> (NonZero Int) -> Bool
prop_divMod (NonZero x) (NonZero y) = (div x y) * y + (mod x y) == x

powAssoc :: Int -> Int -> Int -> Bool
powAssoc x y z = x ^ (y ^ z) == (x ^ y) ^ z

powComm :: Int -> Int -> Bool
powComm x y = x ^ y == y ^ x

revRev :: [Int] -> Bool
revRev xs = (reverse . reverse) xs == xs

-- f $ a = fa ???

consPlusPlus :: [Int] -> [Int] -> Bool
consPlusPlus xs ys = foldr (:) xs ys == (++) xs ys

plusPlusConcat :: [[Int]] -> Bool
plusPlusConcat xs = foldr (++) [] xs == concat xs

lengthTake :: Int -> [Int] -> Bool
lengthTake n xs = length (take n xs) == n

readShow :: String -> Bool
readShow x = (read (show x)) == x

square :: Double -> Double
square x = x * x

squareIdentity x = (square . sqrt) x == x

twice f = f . f
fourTimes = twice . twice

capitalizeWord :: String -> String
capitalizeWord "" = ""
capitalizeWord (x:xs) = toUpper x : xs

idem x =
  (capitalizeWord x == twice capitalizeWord x) &&
  (capitalizeWord x == fourTimes capitalizeWord x)

idem' :: [Double] -> Bool
idem' x =
  (sort x == twice sort x) &&
  (sort x == fourTimes sort x)

data Fool
  = Fulse
  | Frue
  deriving (Eq, Show)

foolGenEqual :: Gen Fool
foolGenEqual = do oneof [return Fulse, return Frue]

foolGenWeighted :: Gen Fool
foolGenWeighted = do frequency [(2, return Fulse), (1, return Frue)]

main :: IO ()
main = do
  quickCheck prop_halfIdentity
  quickCheck prop_listOrdered
  quickCheck plusAssociative
  quickCheck plusCommutative
  quickCheck multAssociative
  quickCheck multCommutative
  quickCheck prop_quoteRem
  quickCheck prop_divMod
  quickCheck powAssoc
  quickCheck powComm
  quickCheck revRev
  quickCheck consPlusPlus
  quickCheck plusPlusConcat
  quickCheck lengthTake
  quickCheck readShow
  quickCheck squareIdentity
  quickCheck idem
  quickCheck idem'
