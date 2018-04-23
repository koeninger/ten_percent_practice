{-# LANGUAGE InstanceSigs #-}

import Data.Char


cap :: [Char] -> [Char]
cap xs = map toUpper xs

rev :: [Char] -> [Char]
rev xs = reverse xs

composed :: [Char] -> [Char]
composed = cap . rev

fmapped :: [Char] -> [Char]
fmapped = cap <$> rev

tupled :: [Char] -> ([Char], [Char])
tupled = (,) <$> cap <*> rev

tupled' :: [Char] -> ([Char], [Char])
tupled' = do
  a <- cap
  b <- rev
  return (a, b)

tupled'' :: [Char] -> ([Char], [Char])
tupled'' =
  cap >>= \a ->
            rev >>= \b ->
                      return (a, b)

newtype Reader r a = Reader { runReader :: r -> a }

instance Functor (Reader r) where
  fmap f (Reader ra) = Reader $ (f . ra)

ask :: Reader a a
ask = Reader id

myLiftA2 :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
myLiftA2 fn a b = fn <$> a <*> b

asks :: (r -> a) -> Reader r a
asks f = Reader f

instance Applicative (Reader r) where
  pure :: a -> Reader r a
  pure a = Reader $ const a

  (<*>) :: Reader r (a -> b)
        -> Reader r a
        -> Reader r b
  (Reader rab) <*> (Reader ra) =
    Reader $ \r -> (rab r) (ra r)

instance Monad (Reader r) where
  return = pure

  (>>=) :: Reader r a
        -> (a -> Reader r b)
        -> Reader r b
  (Reader ra) >>= aRb =
    Reader $ \r -> runReader ((aRb) (ra r)) $ r

newtype HumanName = HumanName String deriving (Eq, Show)

newtype DogName = DogName String deriving (Eq, Show)

newtype Address = Address String deriving (Eq, Show)

data Person =
  Person {
    humanName :: HumanName
  , dogName :: DogName
  , address :: Address
  } deriving (Eq, Show)

data Dog =
  Dog {
    dogsName :: DogName
  , dogsAddress :: Address
  } deriving (Eq, Show)

getDogRM :: Person -> Dog
getDogRM = do
  name <- dogName
  addy <- address
  return $ Dog name addy

getDogRM' :: Reader Person Dog
getDogRM' = do
  name <- Reader dogName
  addy <- Reader address
  return $ Dog name addy
