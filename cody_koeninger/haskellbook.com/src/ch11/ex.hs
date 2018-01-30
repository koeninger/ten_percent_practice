{-# LANGUAGE FlexibleInstances #-}

import Data.Char (toUpper)
import Data.List (intercalate)
import Data.List.Split (splitOn)
    
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

data Quantum = Yes | No | Both deriving (Eq, Show)

convert1 :: Quantum -> Bool
convert1 Yes = False
convert1 No = False
convert1 Both = False

convert2 :: Quantum -> Bool
convert2 Yes = True
convert2 No = False
convert2 Both = False
                
convert3 :: Quantum -> Bool
convert3 Yes = True
convert3 No = True
convert3 Both = False

convert4 :: Quantum -> Bool
convert4 Yes = True
convert4 No = True
convert4 Both = True

convert5 :: Quantum -> Bool
convert5 Yes = False
convert5 No = True
convert5 Both = True

convert6 :: Quantum -> Bool
convert6 Yes = False
convert6 No = False
convert6 Both = True

convert7 :: Quantum -> Bool
convert7 Yes = True
convert7 No = False
convert7 Both = True

convert8 :: Quantum -> Bool
convert8 Yes = False
convert8 No = True
convert8 Both = False
                
isSubseqOf :: (Eq a) => [a] -> [a] -> Bool
isSubseqOf [] _ = True
isSubseqOf _ [] = False
isSubseqOf xs@(x:xt) ys@(y:yt) =
    (x == y && isSubseqOf xt yt) ||
    isSubseqOf xs yt

capitalizeWords :: String -> [(String, String)]
capitalizeWords = map capitalizeToPair . words
                   
capitalizeToPair :: String -> (String, String)
capitalizeToPair "" = ("", "")
capitalizeToPair xs@(x:xt) = (xs, toUpper x : xt)                  

capitalizeWord :: String -> String
capitalizeWord "" = ""
capitalizeWord (x:xs) = toUpper x : xs

capitalizeParagraph :: String -> String
capitalizeParagraph p = intercalate ". " $ map capitalizeWord $ splitOn ". " p
