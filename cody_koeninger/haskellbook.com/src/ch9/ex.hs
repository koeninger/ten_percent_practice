import Data.Bool
import Data.Char
    
eftBool :: Bool -> Bool -> [Bool]
eftBool from to = from : rest
  where rest = if from == to then [] else eftBool (succ from) to
    

eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd from to = from : rest
  where rest = if from == to then [] else eftOrd (succ from) to

eft :: (Enum a, Eq a) => a -> a -> [a]
eft from to = from : rest
  where rest = if from == to then [] else eft (succ from) to

myWords :: [Char] -> [[Char]]
myWords [] = []
myWords xs = word : rest
  where word = takeWhile (/= ' ') xs
        rest = myWords $ dropWhile (== ' ') $ dropWhile (/= ' ') xs


firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful\
\ symmetry?"
sentences = firstSen ++ secondSen ++ thirdSen ++ fourthSen

myLines :: [Char] -> [[Char]]
myLines [] = []
myLines xs = line : rest
  where line = takeWhile (/= '\n') xs
        rest = myLines $ dropWhile (== '\n') $ dropWhile (/= '\n') xs

split :: Char -> [Char] -> [[Char]]
split c [] = []
split c xs = chunk : rest
  where chunk = takeWhile (/= c) xs
        rest = split c $ dropWhile (== c) $ dropWhile (/= c) xs

mySqr = [x^2 | x <- [1..5]]

myCube = [y^3 | y <- [1..5]]        

sqrAndCube = [(x, y) | x <- mySqr, y <- myCube]

sqrAndCubeLt50 = [(x, y) | x <- mySqr, y <- myCube, x < 50, y < 50]

useBool = map (\x -> bool x (- x) (x == 3)) [1..10]

filter3s = filter (\x -> rem x 3 == 0)          

count3s = length . filter3s           

stopWords = ["the", "a", "an"]

filterStopWords = filter (\x -> not $ elem x stopWords) . words           

myZip :: [a] -> [b] -> [(a, b)]
myZip _ [] = []
myZip [] _ = []
myZip (x:xs) (y:ys) = (x, y) : myZip xs ys

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ _ [] = []
myZipWith _ [] _ = []
myZipWith f (x:xs) (y:ys) = f x y : myZipWith f xs ys                

myZipMeta :: [a] -> [b] -> [(a, b)]
myZipMeta = myZipWith (,)             

upperOnly :: [Char] -> [Char]            
upperOnly = filter isUpper            

capitalize :: [Char] -> [Char]
capitalize [] = []
capitalize (x:xs) = toUpper x : xs                

allCaps :: [Char] -> [Char]
allCaps = map toUpper

capitalHead :: [Char] -> Char
capitalHead = toUpper . head               
