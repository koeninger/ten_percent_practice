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

checkAll :: IO ()
checkAll = quickBatch (applicative (Cons ("_", "_", 1 :: Integer) Nil))
