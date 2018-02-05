module EitherLib where

    lefts' :: [Either a b] -> [a]
    lefts' = foldr fn [] where
                 fn :: Either a b -> [a] -> [a]
                 fn (Left x) xs = x:xs
                 fn (Right _) xs = xs

    rights' :: [Either a b] -> [b]
    rights' = foldr fn [] where
                 fn :: Either a b -> [b] -> [b]
                 fn (Right x) xs = x:xs
                 fn (Left _) xs = xs

    partitionEithers' :: [Either a b] -> ([a], [b])
    partitionEithers' = foldr fn ([], []) where
                 fn :: Either a b -> ([a], [b]) -> ([a], [b])
                 fn (Left x) (xs, ys) = (x:xs, ys)
                 fn (Right y) (xs, ys) = (xs, y:ys)

    eitherMaybe' :: (b -> c) -> Either a b -> Maybe c
    eitherMaybe' fn (Right x) = Just $ fn x
    eitherMaybe' _ (Left _) = Nothing

    either' :: (a -> c) -> (b -> c) -> Either a b -> c
    either' fn _ (Left x) = fn x
    either' _ fn (Right y) = fn y

    eitherMaybe'' :: (b -> c) -> Either a b -> Maybe c
    eitherMaybe'' fn = either' (const Nothing) (Just . fn)
