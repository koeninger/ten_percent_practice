import Data.Foldable
import Data.Monoid

sum' :: (Foldable t, Num a) => t a -> a
sum' = getSum . foldMap Sum

product' :: (Foldable t, Num a) => t a -> a
product' = getProduct . foldMap Product

elem' :: (Foldable t, Eq a) => a -> t a -> Bool
elem' x xs = foldr (\a b -> b || a == x) False xs

minimum' :: (Foldable t, Ord a) => t a -> Maybe a
minimum' = foldr (\a b ->
  case b of
    Nothing -> Just a
    Just a' -> Just $ min a a') Nothing

maximum' :: (Foldable t, Ord a) => t a -> Maybe a
maximum' = foldr (\a b ->
  case b of
    Nothing -> Just a
    Just a' -> Just $ max a a') Nothing

null' :: (Foldable t) => t a -> Bool
null' = foldr (\_ _ -> False) True

length' :: (Foldable t) => t a -> Int
length' = foldr (\_ s -> s + 1) 0

toList'  :: (Foldable t) => t a -> [a]
toList' = foldr (\x xs -> x : xs) []

fold' :: (Foldable t, Monoid m) => t m -> m
fold' = foldMap id

foldMap' :: (Foldable t, Monoid m) => (a -> m) -> t a -> m
foldMap' f xs = foldr (\a b -> mappend (f a) b) mempty xs

data Constant a b = Constant b

instance Foldable (Constant a) where
  foldMap f (Constant b) = f b

data Two a b = Two a b

instance Foldable (Two a) where
  foldMap f (Two _ b) = f b

data Three a b c = Three a b c

instance Foldable (Three a b) where
  foldMap f (Three _ _ c) = f c

data Three' a b = Three' a b b

instance Foldable (Three' a) where
  foldMap f (Three' _ b b') = mappend (f b) (f b')

data Four' a b = Four' a b b b

instance Foldable (Four' a) where
  foldMap f (Four' _ b b2 b3) = mconcat $ fmap f [b, b2, b3]

filterF ::
  (Applicative f, Foldable t, Monoid (f a)) =>
  (a -> Bool) -> t a -> f a
filterF pred ta = foldMap (\a -> if (pred a) then pure a else mempty) ta
