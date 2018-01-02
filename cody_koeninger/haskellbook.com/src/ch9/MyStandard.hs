module MyStandard where
    import Data.List

    myAnd :: [Bool] -> Bool
    myAnd [] = True
    myAnd (x:xs) = x && myAnd xs

    myOr :: [Bool] -> Bool
    myOr = foldr (||) False

    myAny :: (a -> Bool) -> [a] -> Bool
    myAny _ [] = False
    myAny f (x:xs) = (f x) || myAny f xs

    myElem :: Eq a => a -> [a] -> Bool
    myElem x = myAny (== x)

    myReverse :: [a] -> [a]
    myReverse = foldl' (flip (:)) []

    squish :: [[a]] -> [a]
    squish = foldl (++) []

    squishMap :: (a -> [b]) -> [a] -> [b]
    squishMap f = squish . map f

    squishAgain :: [[a]] -> [a]
    squishAgain = squishMap id

    myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
    myMaximumBy f = foldr1 (\x y -> if (f x y == GT) then x else y)

    myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
    myMinimumBy f = myMaximumBy (flip f)

    myMaximum :: (Ord a) => [a] -> a
    myMaximum = myMaximumBy compare

    myMinimum :: (Ord a) => [a] -> a
    myMinimum = myMinimumBy compare
    
