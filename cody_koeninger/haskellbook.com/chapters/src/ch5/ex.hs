{-# LANGUAGE NoMonomorphismRestriction #-}

module DetermineTheType where

chooseOne :: a -> a -> a
chooseOne x y = x

chooseTwo :: a -> a -> a
chooseTwo x y = y

chooseB :: a -> b -> b
chooseB a b = b
               
example = 1

e1a :: Num a => a
e1a = (* 9) 6

e1b :: Num a => (a, [Char])
e1b = head [(0, "doge"), (1, "kitteh")]

e1c :: (Integer, [Char])
e1c = head [(0 :: Integer, "doge"), (1, "kitteh")]

e1d :: Bool
e1d = if False then True else False

e1e :: Int
e1e = length [1, 2, 3, 4, 5]

e1f :: Bool
e1f = (length [1, 2, 3, 4, 5]) > (length "tacocat")


e2 :: Num a => a
e2 = w where
    x = 5
    y = x + 5
    w = y * 10

e3 :: Num a => a -> a
e3 = z where
    x = 5
    y = x + 5
    z y = y * 10
        
e4 :: Fractional a => a
e4 = f where
    x = 5
    y = x + 5
    f = 4 / y
        
e5 :: [Char]
e5 = f where
    x = "Julie"
    y = " <3 "
    z = "Haskell"
    f = x ++ y ++ z

bigNum = (^) 5 $ 10
         
wahoo = bigNum * 10

c2 = z where
    x = print
    y = print "wohoo"
    z = x "hello world"

c3 = d where
    a = (+)
    b = 5
    c = a 10
    d = c 200

fH :: [a] -> a
fH (x:_) = x

fC :: Ord a => a -> a -> Bool
fC x y = if (x > y) then True else False

fS :: (a, b) -> b
fS (x, y) = y

i :: a -> a
i x = x

c :: a -> b -> a
c x y = x

c'' :: b -> a -> b
c'' x y = x

c' :: a -> b -> b
c' x y = y

r :: [a] -> [a]
r [] = []
r (x:xs) = (r xs) ++ [x]

co :: (b -> c) -> (a -> b) -> a -> c
co f g a = f (g a)

a :: (a -> c) -> a -> a
a f x = x

a' :: (a -> b) -> a -> b
a' f x = f x
