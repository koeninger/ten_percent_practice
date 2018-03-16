{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import Test.QuickCheck
import Test.QuickCheck.Function

a = fmap (+ 1) $ read "[1]" :: [Int]

b = (fmap . fmap) (++ "lol") (Just ["Hi,", "Hello"])

c = fmap (* 2) (\x -> x - 2)

class Funktor f where
  funk :: (a -> b) -> f a -> f b

instance Funktor ((->) r) where
  funk fn f = \x -> fn $ f x

d = fmap ((return '1' ++) . show) (\x -> [x, 1..3])

e :: IO Integer
e = let ioi = readIO "1" :: IO Integer
        changed = fmap (read . ("123"++) . show) ioi
    in fmap (* 3) changed

fId :: (Functor f, Eq (f a)) => f a -> Bool
fId f = fmap id f == f

fCompose :: (Eq (f c), Functor f) => f a -> Fun a b -> Fun b c -> Bool
fCompose fa (Fun _ g) (Fun _ f) = (fmap (f . g) fa) == (fmap f (fmap g fa))

type FC f = f Int -> Fun Int Int -> Fun Int Int -> Bool
type FI f = f Int -> Bool

newtype Identity a = Identity a deriving (Eq, Show, Arbitrary)

instance Functor Identity where
  fmap f (Identity a) = Identity $ f a

data Pair a = Pair a a deriving (Eq, Show)

instance (Arbitrary a) => Arbitrary (Pair a) where
  arbitrary = do
    a <- arbitrary
    return $ Pair a a

instance Functor Pair where
  fmap f (Pair a _) =
    let a' = f a
    in Pair a' a'

data Two a b = Two a b deriving (Eq, Show)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return $ Two a b

instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)

checkAll = do
  quickCheck (fId :: FI (Two Int))
  quickCheck (fCompose :: FC (Two Int))
  quickCheck (fId :: FI Pair)
  quickCheck (fCompose :: FC Pair)
  quickCheck (fId :: FI Identity)
  quickCheck (fCompose :: FC Identity)
