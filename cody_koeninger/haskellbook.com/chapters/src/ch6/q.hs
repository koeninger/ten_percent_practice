import Data.List (sort)

data Person = Person Bool deriving Show

printPerson :: Person -> IO ()
printPerson person = putStrLn (show person)


data Mood =
    Blah
    | Woot deriving (Show, Eq)

settleDown x = if x == Woot
               then Blah
               else x

type Subject = String
type Verb = String
type Object = String

data Sentence =
    Sentence Subject Verb Object
    deriving (Eq, Show)

s1 = Sentence "dogs" "drool"
s2 = Sentence "Julie" "loves" "dogs"


data Rocks =
    Rocks String deriving (Eq, Show, Ord)

data Yeah =
    Yeah Bool deriving (Eq, Show, Ord)

data Papu =
    Papu Rocks Yeah deriving (Eq, Show, Ord)
               
phew = Papu (Rocks "chases") (Yeah True)

truth = Papu (Rocks "chomsky")
        (Yeah True)

equalityForall :: Papu -> Papu -> Bool
equalityForall p p' = p == p'

comparePapus :: Papu -> Papu -> Bool
comparePapus p p' = p > p'

f :: RealFrac a => a
f = 1.0

freud :: Int -> Int
freud x = x         

myX = 1 :: Int

--sigmund :: Num a => a -> a
--sigmund x = myX           

jung :: [Int] -> Int
jung xs = head (sort xs)
          
young :: Ord a => [a] -> a
young xs = head (sort xs)         

mySort :: Ord a => [a] -> [a]
mySort = sort

signifier :: Ord a => [a] -> a
signifier xs = head (mySort xs)
               
chk :: Eq b => (a -> b) -> a -> b -> Bool
chk fn x y = fn x == y

arith :: Num b => (a -> b) -> Integer -> a -> b
arith fn x a = fromInteger x + fn a
