{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import Prelude hiding (Monoid, mempty)
import Test.QuickCheck

class Semigroup a where
  (<>) :: a -> a -> a

class (Semigroup a) => Monoid a where
  mempty :: a
  mappend :: a -> a -> a
  mappend = (<>)

semigroupAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
semigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

monoidLeftIdentity :: (Eq m, Monoid m) => m -> Bool
monoidLeftIdentity x = x <> mempty == x

monoidRightIdentity :: (Eq m, Monoid m) => m -> Bool
monoidRightIdentity x = mempty <> x == x


data Trivial = Trivial deriving (Eq, Show)

instance Semigroup Trivial where
  _ <> _ = Trivial

instance Monoid Trivial where
  mempty = Trivial

instance Arbitrary Trivial where
  arbitrary = return Trivial

newtype Identity a = Identity a deriving (Eq, Show)

instance (Arbitrary a) => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return $ Identity a

instance (Semigroup a) => Semigroup (Identity a) where
  (Identity x) <> (Identity y) = Identity $ x <> y

instance Semigroup [a] where
  (<>) = (++)

data Two a b = Two a b deriving (Eq, Show)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return $ Two a b

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
  (Two x y) <> (Two x' y') = Two (x <> x') (y <> y')

newtype BoolConj = BoolConj Bool deriving (Eq, Show, Arbitrary)

instance Semigroup BoolConj where
  (BoolConj True) <> (BoolConj True) = BoolConj True
  _ <> _ = BoolConj False

newtype BoolDisj = BoolDisj Bool deriving (Eq, Show, Arbitrary)

instance Semigroup BoolDisj where
  (BoolDisj False) <> (BoolDisj False) = BoolDisj False
  _ <> _ = BoolDisj True


data Or a b
  = Fst a
  | Snd b
  deriving (Eq, Show)

instance Semigroup (Or a b) where
  (Snd x) <> _ = Snd x
  (Fst _) <> x = x

instance (Arbitrary a, Arbitrary b) => Arbitrary (Or a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    frequency [ (2, return $ Fst a)
              , (1, return $ Snd b) ]

newtype Combine a b = Combine { unCombine :: (a -> b) } deriving (Arbitrary)

instance (Semigroup b) => Semigroup (Combine a b) where
  (Combine f) <> (Combine g) = Combine $ \x -> ((f x) <> (g x))

newtype Comp a = Comp { unComp :: (a -> a) }

instance Semigroup (Comp a) where
  (Comp f) <> (Comp g) = Comp (f . g)

data Validation a b
  = Fail a
  | Succ b
  deriving (Eq, Show)

instance Semigroup a => Semigroup (Validation a b) where
  (Fail x) <> (Fail y) = Fail (x <> y)
  _ <> (Succ y) = Succ y
  (Succ x) <> (Fail _) = Succ x

instance (Arbitrary a, Arbitrary b) => Arbitrary (Validation a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    frequency [ (1, return $ Fail a)
              , (3, return $ Succ b) ]
    
checkMonoid = do
  quickCheck (semigroupAssoc :: Trivial -> Trivial -> Trivial -> Bool)
  quickCheck (monoidLeftIdentity :: Trivial -> Bool)
  quickCheck (monoidRightIdentity :: Trivial -> Bool)
  quickCheck (semigroupAssoc :: Identity String -> Identity String -> Identity String -> Bool)
  quickCheck (semigroupAssoc :: Two String String -> Two String String -> Two String String -> Bool)
  quickCheck (semigroupAssoc :: BoolConj -> BoolConj -> BoolConj -> Bool)
  quickCheck (semigroupAssoc :: BoolDisj -> BoolDisj -> BoolDisj -> Bool)
  quickCheck (semigroupAssoc :: Or String Trivial -> Or String Trivial -> Or String Trivial -> Bool)
  -- given there's no way to implement Eq for functions, not sure what the intent here was
  -- quickCheck (semigroupAssoc :: Combine String String -> Combine String String -> Combine String String -> Bool)
  quickCheck (semigroupAssoc :: Validation String String -> Validation String String -> Validation String String -> Bool)
