{-# LANGUAGE FlexibleInstances #-}

class TooMany a where
    tooMany :: a -> Bool

instance TooMany Int where
    tooMany i = i > 23
               
instance TooMany (Int, String) where
    tooMany (i, s) = tooMany i || s == "boom"

instance (Num a, TooMany a) => TooMany (a, a) where
    tooMany (x, y) = tooMany (x + y)
    
data FlowerType = Gardenia
                | Daisy
                | Rose
                | Lilac
                  deriving Show

type Gardener = String

data Garden = Garden Gardener FlowerType deriving Show

data Garden' = GardeniaGarden Gardener
    | DaisyGarden Gardener
    | RoseGarden Gardener
    | LilacGarden Gardener
      deriving Show


data OperatingSystem = GnuPlusLinux
                     | OpenBSDPlusNevermind
                     | Mac
                     | Windows
                       deriving (Eq, Show)

data ProgLang = Haskell
              | Agda
              | Idris
              | Purescript
                deriving (Eq, Show)

data Programmer = Programmer {
      os :: OperatingSystem
    , lang :: ProgLang
    } deriving (Eq, Show)

allOperatingSystems =
    [ GnuPlusLinux
    , OpenBSDPlusNevermind
    , Mac
    , Windows
    ]

allLanguages = [Haskell, Agda, Idris, Purescript]

allProgrammers :: [Programmer]
allProgrammers = [Programmer o p | o <- allOperatingSystems, p <- allLanguages]
