import Control.Applicative
import Control.Monad
import Data.Monoid
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

bind :: Monad m => (a -> m b) -> m a -> m b
bind f ma = join $ fmap f ma

data Eith a b
  = Firs a
  | Secon b
  deriving (Eq, Show)

instance Functor (Eith a) where
  fmap f (Firs a) = Firs a
  fmap f (Secon b) = Secon $ f b

instance Applicative (Eith a) where
  pure = Secon
  (Secon f) <*> (Secon x) = Secon $ f x
  (Firs x) <*> (Secon y) = Firs x
  (Secon f) <*> (Firs x) = Firs x
  (Firs x) <*> (Firs y) = Firs x

instance Monad (Eith a) where
  return = Secon
  (Secon b) >>= f = f b
  (Firs a) >>= _ = Firs a

instance (Arbitrary a, Arbitrary b) => Arbitrary (Eith a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    frequency [(1, return $ Firs a)
              ,(3, return $ Secon b)]

instance (Eq a, Eq b) => EqProp (Eith a b) where (=-=) = eq

data Nope a = Nope deriving (Eq, Show)

instance Functor Nope where
  fmap f Nope = Nope

instance Applicative Nope where
  pure x = Nope
  _ <*> _ = Nope

instance Monad Nope where
  return = pure
  _ >>= _ = Nope

instance EqProp (Nope a) where (=-=) = eq

instance Arbitrary (Nope a) where
  arbitrary = return Nope

data PEither b a
  = PLeft a
  | PRight b
  deriving (Eq, Show)

instance Functor (PEither a) where
  fmap f (PRight a) = PRight a
  fmap f (PLeft b) = PLeft $ f b

instance Applicative (PEither a) where
  pure = PLeft
  (PLeft f) <*> (PLeft x) = PLeft $ f x
  (PRight x) <*> (PLeft y) = PRight x
  (PLeft f) <*> (PRight x) = PRight x
  (PRight x) <*> (PRight y) = PRight x

instance Monad (PEither a) where
  return = PLeft
  (PLeft b) >>= f = f b
  (PRight a) >>= _ = PRight a

instance (Arbitrary a, Arbitrary b) => Arbitrary (PEither a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    frequency [(1, return $ PRight a)
              ,(3, return $ PLeft b)]

instance (Eq a, Eq b) => EqProp (PEither a b) where (=-=) = eq

newtype Identity a = Identity a deriving (Eq, Ord, Show)

instance Functor Identity where
  fmap f (Identity x) = Identity (f x)

instance Applicative Identity where
  pure = Identity
  (Identity f) <*> (Identity x) = Identity (f x)

instance Monad Identity where
  return = pure
  (Identity x) >>= f = f x

instance (Eq a) => EqProp (Identity a) where (=-=) = eq

instance (Arbitrary a) => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return (Identity a)

data List a
  = Nil
  | Cons a (List a)
  deriving (Eq, Show)

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons a r) = Cons (f a) (fmap f r)

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

instance Monad List where
  return = pure
  Nil >>= _ = Nil
  (Cons a r) >>= f = mappend (f a) (r >>= f)

instance (Arbitrary a) => Arbitrary (List a) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    frequency [(1, return Nil)
              ,(2, return $ Cons a b)]

instance (Eq a) => EqProp (List a) where (=-=) = eq

j :: Monad m => m (m a) -> m a
j = (>>= id)

l1 :: Monad m => (a -> b) -> m a -> m b
l1 f m = m >>= (return . f)

l2 :: Monad m => (a -> b -> c) -> m a -> m b -> m c
l2 f ma mb = do
  a <- ma
  b <- mb
  return $ f a b

a :: Monad m => m a -> m (a -> b) -> m b
a = flip (<*>)

meh :: Monad m => [a] -> (a -> m b) -> m [b]
meh [] _ = return []
meh (a:as) f = do
  b <- f a
  bs <- meh as f
  return $ b:bs

flipType :: (Monad m) => [m a] -> m [a]
flipType = flip meh id

qbTriple = ("_", "_", 1 :: (Sum Integer))

checkList :: IO ()
checkList = quickBatch (monad (Cons qbTriple Nil))

checkIdentity :: IO ()
checkIdentity = quickBatch (monad (Identity qbTriple))

checkPEither :: IO ()
checkPEither = quickBatch (monad (PLeft qbTriple :: PEither (Sum Integer) ([Char], [Char], Sum Integer)))

checkNope :: IO ()
checkNope = quickBatch (monad (Nope :: Nope ([Char], [Char], Sum Integer)))

checkEith :: IO ()
checkEith = quickBatch (monad (Secon qbTriple :: Eith (Sum Integer) ([Char], [Char], Sum Integer)))
