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

qbTriple = ("_", "_", 1 :: (Sum Integer))

checkEith :: IO ()
checkEith = quickBatch (monad (Secon qbTriple :: Eith (Sum Integer) ([Char], [Char], Sum Integer)))
