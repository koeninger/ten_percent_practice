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

eitherT :: Monad m
        => (a -> m c)
        -> (b -> m c)
        -> EitherT a m b
        -> m c
eitherT a2mc b2mc (EitherT meab) =
  meab >>= (\e -> case e of
               Left a -> a2mc a
               Right b -> b2mc b)

newtype StateT s m a =
  StateT { runStateT :: s -> m (a, s) }

instance (Functor m) => Functor (StateT s m) where
  fmap :: (a -> b) -> StateT s m a -> StateT s m b
  fmap f (StateT run) = StateT (
    \s ->
      let mas = run s
          mbs = fmap
            (\ (a, s) -> ((f a), s))
            mas
      in mbs)

instance (Monad m) => Applicative (StateT s m) where
  pure a = StateT (\s -> pure (a, s))

  (<*>) :: StateT s m (a -> b)
        -> StateT s m a
        -> StateT s m b
  (StateT sma2b) <*> (StateT sma) =
    StateT (
    \s -> do
      (a2b, s2) <- sma2b s
      (a, s3) <- sma s2
      return ((a2b a), s3)
    )

instance (Monad m) => Monad (StateT s m) where
  return = pure

  (>>=) :: StateT s m a
        -> (a -> StateT s m b)
        -> StateT s m b
  (StateT sma) >>= f =
    StateT (
    \s -> do
      (a, s2) <- sma s
      runStateT (f a) s2
    )
