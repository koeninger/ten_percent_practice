{-# LANGUAGE FlexibleInstances #-}

import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

checkList = do
  let t :: [] (Int, Int, [Int])
      t = undefined
  quickBatch (traversable t)

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
  traverse _ Nil = pure Nil
  traverse fn (Cons x y) =
  
instance (Arbitrary a) => Arbitrary (List a) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    frequency [(1, return Nil)
              ,(2, return $ Cons a b)]

instance (Eq a) => EqProp (List a) where (=-=) = eq

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
  
