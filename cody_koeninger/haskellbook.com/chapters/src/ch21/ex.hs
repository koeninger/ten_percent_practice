{-# LANGUAGE FlexibleInstances #-}

import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

newtype Identity a = Identity a  deriving (Eq, Ord, Show)

instance Functor Identity where
  fmap fn (Identity a) = Identity (fn a)

instance Foldable Identity where
  foldMap fn (Identity a) = fn a

instance Traversable Identity where
  traverse fn (Identity a) = fmap Identity $ fn a

instance (Arbitrary a) => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return $ Identity a

instance (Eq a) => EqProp (Identity a) where (=-=) = eq

newtype Flip f a b = Flip (f b a) deriving (Eq, Show)

newtype Constant a b = Constant { getConstant :: a } deriving (Eq, Ord, Show)

instance Functor (Flip Constant b) where
  fmap fn (Flip (Constant x)) = Flip (Constant (fn x))

instance Foldable (Flip Constant b) where
  foldMap fn (Flip (Constant x)) = fn x

instance Traversable (Flip Constant b) where
  traverse fn (Flip (Constant x)) = fmap (Flip . Constant) (fn x)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Flip Constant a b) where
  arbitrary = do
    a <- arbitrary
    return (Flip (Constant { getConstant = a }))

instance (Eq a, Eq b) => EqProp (Flip Constant a b) where (=-=) = eq

data Optional a
  = Nada
  | Yep a
  deriving (Eq, Ord, Show)

instance Functor Optional where
  fmap fn Nada = Nada
  fmap fn (Yep x) = Yep (fn x)

instance Foldable Optional where
  foldMap _ Nada = mempty
  foldMap fn (Yep x) = fn x

instance Traversable Optional where
  traverse fn Nada = pure Nada
  traverse fn (Yep x) = fmap Yep (fn x)

instance (Arbitrary a) => Arbitrary (Optional a) where
  arbitrary = do
    a <- arbitrary
    frequency [(1, return Nada)
              ,(2, return (Yep a))]

instance (Eq a) => EqProp (Optional a) where (=-=) = eq

data List a
  = Nil
  | Cons a (List a)
  deriving (Eq, Ord, Show)

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons x r) = Cons (f x) (fmap f r)

instance Foldable List where
  foldMap _ Nil = mempty
  foldMap f (Cons x y) = mappend (f x) (foldMap f y)

instance Traversable List where
  sequenceA Nil = pure Nil
  sequenceA (Cons x y) = Cons <$> x <*> (sequenceA y)
  
instance (Arbitrary a) => Arbitrary (List a) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    frequency [(1, return Nil)
              ,(2, return $ Cons a b)]

instance (Eq a) => EqProp (List a) where (=-=) = eq

data Three a b c = Three a b c deriving (Eq, Ord, Show)

instance Functor (Three a b) where
  fmap fn (Three a b c) = Three a b (fn c)

instance Foldable (Three a b) where
  foldMap fn (Three a b c) = fn c

instance Traversable (Three a b) where
  traverse fn (Three x y z) = fmap (\z' -> Three x y z') (fn z)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three a b c)

instance (Eq a, Eq b, Eq c) => EqProp (Three a b c) where (=-=) = eq

data Pair a b = Pair a b deriving (Eq, Ord, Show)

instance Functor (Pair a) where
  fmap fn (Pair a b) = Pair a (fn b)

instance Foldable (Pair a) where
  foldMap fn (Pair a b) = fn b

instance Traversable (Pair a) where
  traverse fn (Pair a b) = fmap (\b' -> Pair a b') (fn b)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Pair a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Pair a b)

instance (Eq a, Eq b) => EqProp (Pair a b) where (=-=) = eq

data Big a b = Big a b b deriving (Eq, Ord, Show)

instance Functor (Big a) where
  fmap fn (Big a b b') = Big a (fn b) (fn b')

instance Foldable (Big a) where
  foldMap fn (Big a b b') = mappend (fn b) (fn b')

instance Traversable (Big a) where
  traverse fn (Big a b b2) = (\b' b2' -> Big a b' b2') <$> (fn b) <*> (fn b2)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Big a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    b' <- arbitrary
    return (Big a b b')

instance (Eq a, Eq b) => EqProp (Big a b) where (=-=) = eq

data Bigger a b = Bigger a b b b deriving (Eq, Ord, Show)

instance Functor (Bigger a) where
  fmap fn (Bigger a b b2 b3) = Bigger a (fn b) (fn b2) (fn b3)

instance Foldable (Bigger a) where
  foldMap fn (Bigger a b b2 b3) = mconcat $ fmap fn [b, b2, b3]

instance Traversable (Bigger a) where
  traverse fn (Bigger a b b2 b3) = (Bigger a) <$> (fn b) <*> (fn b2) <*> (fn b3)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Bigger a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    b2 <- arbitrary
    b3 <- arbitrary
    return (Bigger a b b2 b3)

instance (Eq a, Eq b) => EqProp (Bigger a b) where (=-=) = eq

checkBigger = do
  let t :: Bigger Int (Int, Int, [Int])
      t = undefined
  quickBatch (traversable t)

checkBig = do
  let t :: Big Int (Int, Int, [Int])
      t = undefined
  quickBatch (traversable t)
  
checkPair = do
  let t :: Pair Int (Int, Int, [Int])
      t = undefined
  quickBatch (traversable t)

checkThree = do
  let t :: Three Int Int (Int, Int, [Int])
      t = undefined
  quickBatch (traversable t)

checkList = do
  let t :: List (Int, Int, [Int])
      t = undefined
  quickBatch (traversable t)

checkOptional = do
  let t :: Optional (Int, Int, [Int])
      t = undefined
  quickBatch (traversable t)

checkConstant = do
  let t :: Flip Constant Int (Int, Int, [Int])
      t = undefined
  quickBatch (traversable t)

checkIdentity = do
  let t :: Identity (Int, Int, [Int])
      t = undefined
  quickBatch (traversable t)
  
