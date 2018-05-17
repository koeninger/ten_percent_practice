{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE ScopedTypeVariables #-}

newtype MaybeT m a =
  MaybeT { runMaybeT :: m (Maybe a) }

instance (Functor m) => Functor (MaybeT m) where
  fmap f (MaybeT mma) = MaybeT $ (fmap . fmap) f mma

instance (Applicative m) => Applicative (MaybeT m) where
  pure = MaybeT . pure . pure

  (<*>) :: forall a b. MaybeT m (a -> b)
        -> MaybeT m a
        -> MaybeT m b
  (MaybeT mma2b) <*> (MaybeT mma) =
    let f :: m (Maybe a -> Maybe b)
        f = fmap (<*>) mma2b
    in
    MaybeT $ f <*> mma
