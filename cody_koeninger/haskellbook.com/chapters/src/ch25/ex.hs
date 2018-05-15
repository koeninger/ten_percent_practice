{-# LANGUAGE InstanceSigs #-}

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
