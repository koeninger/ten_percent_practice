{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}

import Control.Applicative
import Control.Compose
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

data Pair a = Pair a a deriving (Eq, Show)

instance Functor Pair where
  fmap f (Pair x y) = Pair (f x) (f y)

instance Applicative Pair where
  pure x = Pair x x
  (Pair f g) <*> (Pair x y) = Pair (f x) (g y)

instance (Arbitrary a) => Arbitrary (Pair a) where
  arbitrary = do
    a <- arbitrary
    a' <- arbitrary
    return $ Pair a a'

instance (Eq a) => EqProp (Pair a) where (=-=) = eq

data Two a b = Two a b deriving (Eq, Show)

instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)

instance (Monoid a) => Applicative (Two a) where
  pure x = Two mempty x
  (Two a f) <*> (Two a' x) = Two (mappend a a') (f x)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return $ Two a b

instance (Eq a, Eq b) => EqProp (Two a b) where (=-=) = eq    

data Three a b c = Three a b c deriving (Eq, Show)

instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

instance (Monoid a, Monoid b) => Applicative (Three a b) where
  pure x = Three mempty mempty x
  (Three a b f) <*> (Three a' b' c) = Three (mappend a a') (mappend b b') (f c)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return $ Three a b c

instance (Eq a, Eq b, Eq c) => EqProp (Three a b c) where (=-=) = eq    

data Three' a b = Three' a b b deriving (Eq, Show)

instance Functor (Flip Three' b) where
  fmap f (Flip (Three' a b b')) = Flip (Three' (f a) b b')

instance (Monoid b) => Applicative (Flip Three' b) where
  pure x = Flip (Three' x mempty mempty)
  (Flip (Three' f x y)) <*> (Flip (Three' a x' y')) = Flip $ Three' (f a) (mappend x x') (mappend y y')

instance (Arbitrary a, Arbitrary b) => Arbitrary (Flip Three' a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    b' <- arbitrary
    return $ Flip $ Three' a b b'

instance (Eq a, Eq b) => Eq (Flip Three' a b) where
  (==) (Flip x) (Flip y) = x == y

instance (Eq a, Eq b) => EqProp (Flip Three' a b) where (=-=) = eq    

instance (Show a, Show b) => Show (Flip Three' a b) where
  show (Flip x) = "Flip " ++ show x

data Four a b c d = Four a b c d deriving (Eq, Show)

instance Functor (Four a b c) where
  fmap f (Four a b c d) = Four a b c (f d)

instance (Monoid a, Monoid b, Monoid c) => Applicative (Four a b c) where
  pure x = Four mempty mempty mempty x
  (Four a b c f) <*> (Four a' b' c' x) = Four (mappend a a') (mappend b b') (mappend c c') (f x)
  
instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    d <- arbitrary
    return $ Four a b c d

instance (Eq a, Eq b, Eq c, Eq d) => EqProp (Four a b c d) where (=-=) = eq    

data Four' a b = Four' a a a b deriving (Eq, Show)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Four' a b) where
  arbitrary = do
    a <- arbitrary
    a2 <- arbitrary
    a3 <- arbitrary
    b <- arbitrary
    return $ Four' a a2 a3 b

instance (Eq a, Eq b) => EqProp (Four' a b) where (=-=) = eq    

instance Functor (Four' a) where
  fmap f (Four' a a2 a3 b) = Four' a a2 a3 (f b)

instance (Monoid a) => Applicative (Four' a) where
  pure x = Four' mempty mempty mempty x
  (Four' x y z f) <*> (Four' x' y' z' b) = Four' (mappend x x') (mappend y y') (mappend z z') (f b)


combos :: [a] -> [b] -> [c] -> [(a, b, c)]
combos = liftA3 (,,)

qbTriple = ("_", "_", 1 :: (Sum Integer))

checkFour' :: IO ()
checkFour' = quickBatch (applicative (Four qbTriple qbTriple qbTriple qbTriple))

checkFour :: IO ()
checkFour = quickBatch (applicative (Four qbTriple qbTriple qbTriple qbTriple))

checkThree' :: IO ()
checkThree' = quickBatch (applicative (Flip (Three' qbTriple qbTriple qbTriple)))

checkThree :: IO ()
checkThree = quickBatch (applicative (Three qbTriple qbTriple qbTriple))

checkTwo :: IO ()
checkTwo = quickBatch (applicative (Two qbTriple qbTriple))

checkPair :: IO ()
checkPair = quickBatch (applicative (Pair qbTriple qbTriple))

checkValidation :: IO ()
checkValidation = quickBatch (applicative ((Suc qbTriple) :: Validation [Char] ([Char], [Char], Sum Integer)))

checkZipList :: IO ()
checkZipList = quickBatch (applicative (ZipList' (Cons qbTriple Nil)))

checkList :: IO ()
checkList = quickBatch (applicative (Cons qbTriple Nil))
