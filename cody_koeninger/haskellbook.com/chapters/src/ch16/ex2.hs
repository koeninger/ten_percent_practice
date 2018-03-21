{-# LANGUAGE FlexibleInstances #-}

-- wrong kind for Functor
-- data Bool = False | True

data BoolAndSomethingElse a = False' a | True' a

instance Functor BoolAndSomethingElse where
  fmap f (False' a) = False' (f a)
  fmap f (True' a) = True' (f a)

data BoolAndMaybeSomethingElse a = Falsish | Truish a

instance Functor BoolAndMaybeSomethingElse where
  fmap _ Falsish = Falsish
  fmap f (Truish a) = Truish (f a)
  
newtype Mu f = Inf { outF :: f (Mu f) }

-- Mu is (* -> *) -> *, not * -> *
