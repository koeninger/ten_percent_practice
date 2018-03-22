{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}

import Test.QuickCheck
import Test.QuickCheck.Function
import Control.Compose

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

data Three a b c = Three a b c deriving (Eq, Show)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return $ Three a b c

instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

data Three' a b = Three' a b b deriving (Eq, Show)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Flip Three' a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    b' <- arbitrary
    return $ Flip (Three' a b b')

instance Functor (Flip Three' b) where
  fmap f (Flip (Three' a b b')) = Flip (Three' (f a) b b')

instance (Eq a, Eq b) => Eq (Flip Three' a b) where
  (==) (Flip x) (Flip y) = x == y

instance (Show a, Show b) => Show (Flip Three' a b) where
  show (Flip x) = "Flip " ++ show x

data Four a b c d = Four a b c d deriving (Eq, Show)

instance Functor (Four a b c) where
  fmap f (Four a b c d) = Four a b c (f d)

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    d <- arbitrary
    return $ Four a b c d

data Four' a b = Four' a a a b deriving (Eq, Show)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Four' a b) where
  arbitrary = do
    a <- arbitrary
    a2 <- arbitrary
    a3 <- arbitrary
    b <- arbitrary
    return $ Four' a a2 a3 b

instance Functor (Four' a) where
  fmap f (Four' a a2 a3 b) = Four' a a2 a3 (f b)

data Trivial = Trivial deriving (Eq, Show)

-- Trivial has wrong kind
-- instance Functor Trivial where
--  fmap f Trivial = Trivial

data Sum a b
  = First a
  | Second b
  deriving (Eq, Show)

instance Functor (Sum a) where
  fmap f (First x) = First x
  fmap f (Second b) = Second (f b)


checkAll = do
  quickCheck (fId :: FI (Four' Int))
  quickCheck (fCompose :: FC (Four' Int))
  quickCheck (fId :: FI (Four Int Int Int))
  quickCheck (fCompose :: FC (Four Int Int Int))
  quickCheck (fId :: FI (Flip Three' Int))
  quickCheck (fCompose :: FC (Flip Three' Int))
  quickCheck (fId :: FI (Three Int Int))
  quickCheck (fCompose :: FC (Three Int Int))
  quickCheck (fId :: FI (Two Int))
  quickCheck (fCompose :: FC (Two Int))
  quickCheck (fId :: FI Pair)
  quickCheck (fCompose :: FC Pair)
  quickCheck (fId :: FI Identity)
  quickCheck (fCompose :: FC Identity)
