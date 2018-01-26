notThe :: String -> Maybe String
notThe "the" = Nothing
notThe x = Just x

replaceThe :: String -> String
replaceThe xs =
    unwords $
    map (\x ->
         case x of
           Nothing -> "a"
           Just s -> s
        ) $
    map notThe $
    words xs

pointlessReplaceThe :: String -> String
pointlessReplaceThe =
    unwords .
    map (\x ->
         case x of
           Nothing -> "a"
           Just s -> s
        ) .
    map notThe .
    words
          
vowels = "aeiouy"

countTheBeforeVowel :: String -> Integer
countTheBeforeVowel xs = recur 0 (words xs)
    where recur c ("the" : w : ws) =
              if elem (head w) vowels
              then recur (1 + c) ws
              else recur c ws
          recur c (w:ws) = recur c ws
          recur c [] = c

isVowel = flip elem vowels
           
countVowels :: String -> Int
countVowels = length . (filter isVowel)

newtype Word' = Word' String deriving (Eq, Show)

mkWord :: String -> Maybe Word'
mkWord s = if countVowels s * 2 > length s
           then Nothing
           else Just $ Word' s

data Nat
    = Zero
    | Succ Nat
    deriving (Eq, Show)

natToInteger :: Nat -> Integer
natToInteger Zero = 0
natToInteger (Succ n) = 1 + natToInteger n

integerToNat :: Integer -> Maybe Nat
integerToNat 0 = Just Zero
integerToNat n = if n < 0
                 then Nothing
                 else fmap Succ $ integerToNat $ n - 1
         
