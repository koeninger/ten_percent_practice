{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import Control.Applicative
import Data.List (elemIndex)
import Data.Monoid
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

added :: Maybe Integer
added = (+3) <$> (lookup 3 $ zip [1,2,3] [4,5,6])

y :: Maybe Integer
y = lookup 3 $ zip [1,2,3] [4,5,6]

z :: Maybe Integer
z = lookup 2 $ zip [1,2,3] [4,5,6]

tupled :: Maybe (Integer, Integer)
tupled = (,) <$> y <*> z
-- tupled = liftA2 (,) y z

x2 :: Maybe Int
x2 = elemIndex 3 [1,2,3,4,5]

y2 :: Maybe Int
y2 = elemIndex 4 [1,2,3,4,5]

max' :: Int -> Int -> Int
max' = max

maxed :: Maybe Int
maxed = max' <$> x2 <*> y2

xs = [1, 2, 3]
ys = [4, 5, 6]

x3 :: Maybe Integer
x3 = lookup 3 $ zip xs ys

y3 :: Maybe Integer
y3 = lookup 2 $ zip xs ys

summed :: Maybe Integer
summed = sum <$> ((,) <$> x3 <*> y3)

newtype Identity a = Identity a
  deriving (Eq, Ord, Show)

instance Functor Identity where
  fmap f (Identity x) = Identity $ f x

instance Applicative Identity where
  pure = Identity
  (Identity f) <*> (Identity x) = Identity $ f x

newtype Constant a b = Constant { getConstant :: a }
  deriving (Eq, Ord, Show)

instance Functor (Constant a) where
  fmap f (Constant c) = Constant c

instance Monoid a => Applicative (Constant a) where
  pure x = Constant mempty
  (Constant x) <*> (Constant y) = Constant (mappend x y)

fu1 = const <$> Just "Hello" <*> pure "World"

fu2 = (,,,) <$> Just 90 <*> Just 10 <*> Just "Tierness" <*> pure [1,2,3]

data List a
  = Nil
  | Cons a (List a)
  deriving (Eq, Show)

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons x r) = Cons (f x) (fmap f r)

instance Monoid (List a) where
  mempty = Nil
  mappend Nil r = r
  mappend (Cons x y) r = Cons x (mappend y r)

instance Foldable List where
  foldMap _ Nil = mempty
  foldMap f (Cons x y) = mappend (f x) (foldMap f y)

instance Applicative List where
  pure x = Cons x Nil
  fs <*> xs = foldMap (\f -> fmap f xs) fs

instance (Arbitrary a) => Arbitrary (List a) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    frequency [(1, return Nil)
              ,(2, return $ Cons a b)]

instance (Eq a) => EqProp (List a) where (=-=) = eq

take' :: Int -> List a -> List a
take' _ Nil = Nil
take' x (Cons a r) | x > 0 = Cons a (take' (x - 1) r)
                   | otherwise = Nil

repeat' :: a -> List a
repeat' x = Cons x (repeat' x)

newtype ZipList' a = ZipList' (List a) deriving (Eq, Show, Arbitrary)

instance Eq a => EqProp (ZipList' a) where
  xs =-= ys = eq xs' ys'
    where xs' = let (ZipList' l) = xs
                in take' 3000 l
          ys' = let (ZipList' l) = ys
                in take' 3000 l

instance Functor ZipList' where
  fmap f (ZipList' xs) =
    ZipList' $ fmap f xs

instance Applicative ZipList' where
  pure x = ZipList' (repeat' x)
  (ZipList' zf) <*> (ZipList' zx) = ZipList' (recur zf zx)
    where
      recur _ Nil = Nil
      recur Nil _ = Nil
      recur (Cons f fs) (Cons x xs) = Cons (f x) (recur fs xs)
                             
data Validation e a
  = Fail e
  | Suc a
  deriving (Eq, Show)

instance Functor (Validation e) where
  fmap _ (Fail x) = Fail x
  fmap f (Suc x) = Suc (f x)

instance Monoid e => Applicative (Validation e) where
  pure x = Suc x
  (Fail x) <*> (Fail y) = Fail (mappend x y)
  (Fail x) <*> (Suc _) = Fail x
  (Suc _) <*> (Fail x) = Fail x
  (Suc f) <*> (Suc x) = Suc (f x)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Validation a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    frequency [(1, return $ Fail a)
              ,(2, return $ Suc b)]

instance (Eq a, Eq b) => EqProp (Validation a b) where (=-=) = eq

checkValidation :: IO ()
checkValidation = quickBatch (applicative ((Suc ("_", "_", 1 :: Integer)) :: Validation [Char] ([Char], [Char], Integer)))

checkZipList :: IO ()
checkZipList = quickBatch (applicative (ZipList' (Cons ("_", "_", 1 :: Integer) Nil)))

checkList :: IO ()
checkList = quickBatch (applicative (Cons ("_", "_", 1 :: Integer) Nil))

