import Data.List

factorialNaive n = if (n < 1) then 1 else n * factorialNaive (n - 1)

factorialScan n =
    facts !! (n - 1) where
        facts = scanl (*) 1 [2..]

stops = "pbtdkg"

vowels = "aeiou"

stopVowelStop = [ (s, v, s2) | s <- stops, v <- vowels, s2 <- stops]         

pStopVowelStop = filter (\(s, _, _) -> s == 'p') stopVowelStop                

nouns = words "fox cat dog bat"

verbs = words "eat sleep code repeat"

nounVerbNoun = [ (n, v, n2) | n <- nouns, v <- verbs, n2 <- nouns ]        

avgWordLength x =
    (fromIntegral (sum (map length (words x)))) /
    (fromIntegral (length (words x)))

myAnd :: [Bool] -> Bool    
myAnd = foldr (&&) True

myOr :: [Bool] -> Bool
myOr = foldr (||) False

myAny :: (a -> Bool) -> [a] -> Bool
myAny fn = foldr (\x y -> y || fn x) False

myElem :: Eq a => a -> [a] -> Bool
myElem a = foldr (\x y -> y || a == x) False

myElem2 :: Eq a => a -> [a] -> Bool
myElem2 a = myAny (== a)

myReverse :: [a] -> [a]
myReverse = foldl (flip (:)) []             

myMap :: (a -> b) -> [a] -> [b]
myMap fn = foldr (\x y -> fn x : y) []

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter fn = foldr (\x y -> if (fn x) then x : y else y) []

squish :: [[a]] -> [a]
squish = foldr (++) []

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap f = squish . map f

squishAgain :: [[a]] -> [a]
squishAgain = squishMap id

myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy fn = foldr1 (\x y -> if (fn x y == GT) then x else y)

myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy fn = foldr1 (\x y -> if (fn x y == LT) then x else y)
