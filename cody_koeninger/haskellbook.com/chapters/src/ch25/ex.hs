{-# LANGUAGE InstanceSigs #-}

import Control.Monad

newtype Compose f g a = Compose { getCompose :: f (g a) } deriving (Eq, Show)

instance (Functor f, Functor g) => Functor (Compose f g) where
  fmap f (Compose fga) = Compose $ (fmap . fmap) f fga

instance (Applicative f, Applicative g) => Applicative (Compose f g) where
  pure :: a -> Compose f g a
  pure = Compose . pure . pure

  (<*>) :: Compose f g (a -> b)
        -> Compose f g a
        -> Compose f g b
  (Compose fga2b) <*> (Compose fga) =
    Compose $ (fmap (\ga2b -> (\ga -> ga2b <*> ga)) fga2b) <*> fga 

instance (Foldable f, Foldable g) => Foldable (Compose f g) where
  foldMap :: (Monoid m) => (a -> m) -> Compose f g a -> m
  foldMap a2m (Compose fga) = (foldMap . foldMap) a2m fga

instance (Traversable f, Traversable g) => Traversable (Compose f g) where
  traverse :: (Applicative p) => (a -> p b) -> Compose f g a -> p (Compose f g b)
  traverse a2pb (Compose fga) =
    fmap Compose $
    traverse (\ga -> traverse a2pb ga) fga

class Bifunctor p where
  {-# MINIMAL bimap | first, second #-}
  bimap :: (a -> b)
        -> (c -> d)
        -> p a c
        -> p b d
  bimap f g = first f . second g

  first :: (a -> b) -> p a c -> p b c
  first f = bimap f id

  second :: (b -> c) -> p a b -> p a c
  second = bimap id

data Deux a b = Deux a b

instance Bifunctor Deux where
  bimap f g (Deux a b) = Deux (f a) (g b)

data Const a b = Const a

instance Bifunctor Const where
  bimap f g (Const a) = Const (f a)

data Drei a b c = Drei a b c

instance Bifunctor (Drei a) where
  bimap f g  (Drei a b c) = Drei a (f b) (g c)

data SuperDrei a b c = SuperDrei a b

instance Bifunctor (SuperDrei a) where
  bimap f g (SuperDrei a b) = SuperDrei a (f b)

data SemiDrei a b c = SemiDrei a

-- This seems really pointless
instance Bifunctor (SemiDrei a) where
  bimap f g (SemiDrei a) = SemiDrei a

data Quadriceps a b c d = Quadzzz a b c d

instance Bifunctor (Quadriceps a b) where
  bimap f g (Quadzzz a b c d) = Quadzzz a b (f c) (g d)

data Either' a b
  = Left' a
  | Right' b

instance Bifunctor Either' where
  bimap f g (Left' a) = Left' (f a)
  bimap f g (Right' b) = Right' (g b)

newtype Identity a = Identity { runIdentity :: a }
  deriving (Eq, Show)

newtype IdentityT f a = IdentityT { runIdentityT :: f a }
  deriving (Eq, Show)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

instance (Functor f) => Functor (IdentityT f) where
  fmap fn (IdentityT fa) = IdentityT (fmap fn fa)

instance Applicative Identity where
  pure = Identity

  (Identity f) <*> (Identity x) = Identity (f x)

instance (Applicative f) => Applicative (IdentityT f) where
  pure = IdentityT . pure

  (IdentityT ffn) <*> (IdentityT fx) = IdentityT (ffn <*> fx)

instance (Monad m) => Monad (IdentityT m) where
  return = pure

  (>>=) :: IdentityT m a
        -> (a -> IdentityT m b)
        -> IdentityT m b
  (IdentityT ma) >>= f =
    let aimb = ma >>= (runIdentityT . f)
    in IdentityT aimb
