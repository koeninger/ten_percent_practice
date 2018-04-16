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
checkIdentity = do
  let t :: Identity (Int, Int, [Int])
      t = undefined
  quickBatch (traversable t)
  
