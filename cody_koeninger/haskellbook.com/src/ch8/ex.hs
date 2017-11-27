recurSum :: (Ord a, Num a) => a -> a
recurSum x
    | x < 1 = 0
    | otherwise = x + recurSum (x - 1)

recurMult :: (Integral a) => a -> a -> a
recurMult x y
    | x < 0 =
        negate $ recurMult (abs x) y
    | x == 0 =
        0
    | otherwise =
        y + recurMult (x - 1) y

mc91 :: (Ord a, Num a) => a -> a                  
mc91 x
    | x > 100 = x - 10
    | otherwise = mc91 $ mc91 $ x + 11
