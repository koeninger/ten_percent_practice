addOneIfOdd n =
    case odd n of
      True -> f n
      False -> n
    where f = \n -> n + 1

addFive = \x -> \y -> (if x > y then y else x) + 5

mflip f x y = f y x          

f :: (a, b, c) -> (d, e, f) -> ((a, d), (c, f))
f (a, b, c) (d, e, f) = ((a, d), (c, f))

functionC x y =
    case x > y of
      True -> x
      False -> y

ifEvenAdd2 n =
    case even n of
      True -> n + 2
      False -> n

nums x =
    case compare x 0 of
      LT -> -1
      EQ -> 0
      GT -> 1


avgGrade x
    | y >= 0.9 = 'A'
    | y >= 0.8 = 'B'
    | y >= 0.7 = 'C'
    | y >= 0.59 = 'D'
    | otherwise = 'F'
    where y = x / 100

-- XXX book instructions to use divMod seem wrong for negative numbers              
tensDigit :: Integral a => a -> a
tensDigit = fst . (flip quotRem) 10

hunsDigit :: Integral a => a -> a
hunsDigit = fst . (flip quotRem) 100             

foldBool :: a -> a -> Bool -> a
foldBool x y p
    | p = y
    | otherwise = x

foldBool2 :: a -> a -> Bool -> a
foldBool2 x y p =
    case p of
      True -> y
      False -> x

g :: (a -> b) -> (a, c) -> (b, c)
g f (a, c) = (f a, c)

roundTrip :: (Show a, Read a) => a -> a
roundTrip = read . show

roundTrip2 :: (Show a, Read b) => a -> b
roundTrip2 = read . show

-- print ((roundTrip2 4) :: Int)             
