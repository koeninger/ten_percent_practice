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

instance (Monad m) => Monad (MaybeT m) where
  return = pure

  (>>=) :: MaybeT m a
        -> (a -> MaybeT m b)
        -> MaybeT m b
  (MaybeT mma) >>= f =
    MaybeT (
    mma >>= (
        \ma ->
          case ma of
            Nothing -> return Nothing
            Just a -> runMaybeT (f a)))
                         
newtype EitherT e m a =
  EitherT { runEitherT :: m (Either e a) }

instance Functor m => Functor (EitherT e m) where
  fmap f (EitherT me) = EitherT $ (fmap . fmap) f me

instance Applicative m => Applicative (EitherT e m) where
  pure = EitherT . pure . pure

  (<*>) :: EitherT e m (a -> b)
        -> EitherT e m a
        -> EitherT e m b
  (EitherT mea2b) <*> (EitherT mea) =
    let f = fmap (<*>) mea2b
    in
      EitherT $ f <*> mea
 
instance (Monad m) => Monad (EitherT e m) where
  return = pure

  (>>=) :: EitherT e m a
        -> (a -> EitherT e m b)
        -> EitherT e m b
  (EitherT mea) >>= f =
    EitherT (
    mea >>= (
        \ea ->
          case ea of
            Left e -> return (Left e)
            Right a -> runEitherT (f a)))
    
swapEitherT :: (Functor m)
            => EitherT e m a
            -> EitherT a m e
swapEitherT (EitherT mea) = EitherT $ fmap swapEither mea

swapEither :: Either e a
           -> Either a e
swapEither (Left e) = Right e
swapEither (Right a) = Left a
