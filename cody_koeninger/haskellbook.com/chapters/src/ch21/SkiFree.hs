{-# LANGUAGE FlexibleContexts #-}

module SkiFree where

import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

data S n a = S (n a) a deriving (Eq, Show)

instance ( Functor n
         , Arbitrary (n a)
         , Arbitrary a )
        => Arbitrary (S n a) where
  arbitrary =
    S <$> arbitrary <*> arbitrary

instance ( Eq (n a), Eq a )
        => EqProp (S n a) where
  (=-=) = eq

instance (Functor n) => Functor (S n) where
  fmap fn (S n a)= S (fmap fn n) (fn a)

instance (Foldable n) => Foldable (S n) where
  foldMap fn (S n a) = mappend (foldMap fn n) (fn a)

instance Traversable n => Traversable (S n) where
  traverse fn (S n a) = S <$> (traverse fn n) <*> fn a

main =
  sample' (arbitrary :: Gen (S [] Int))

checkS = do
  let t :: S [] (Int, Int, [Int])
      t = undefined
  quickBatch (traversable t)      
