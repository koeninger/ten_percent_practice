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
