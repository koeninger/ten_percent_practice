import Data.Monoid
import Test.QuickCheck

data Optional a
  = Nada
  | Only a
  deriving (Eq, Show)

instance Monoid a => Monoid (Optional a) where
  mempty = Nada
  mappend (Only x) (Only y) = Only $ mappend x y
  mappend _ _ = Nada
 
type Verb = String
type Adjective = String
type Adverb = String
type Noun = String
type Exclamation = String

madlibbin :: Exclamation -> Adverb -> Noun -> Adjective -> String
madlibbin ex adv n adj = mconcat [ex, "! he said ", adv, " as he jumped into his car ", n, " and drove off with his ", adj, " wife."]

monoidAssoc :: (Eq m, Monoid m) => m -> m -> m -> Bool
monoidAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

monoidLeftId :: (Eq m, Monoid m) => m -> Bool
monoidLeftId a = (mempty <> a) == a

monoidRightId :: (Eq m, Monoid m) => m -> Bool
monoidRightId a = (a <> mempty) == a

newtype First' a =
  First' { getFirst' :: Optional a }
  deriving (Eq, Show)

instance Monoid (First' a) where
  mempty = First' Nada
  mappend (First' Nada) y = y
  mappend x y = x

instance Arbitrary a => Arbitrary (First' a) where
  arbitrary = do
    a <- arbitrary
    frequency [ (1, return $ First' Nada)
              , (3, return $ First' $ Only a) ]

type FirstMappend = First' String -> First' String -> First' String -> Bool
type FirstId = First' String -> Bool

checkFirst = do
  quickCheck (monoidAssoc :: FirstMappend)
  quickCheck (monoidLeftId :: FirstId)
  quickCheck (monoidRightId :: FirstId)

