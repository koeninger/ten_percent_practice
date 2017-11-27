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
