module MaybeLib where

    isJust :: Maybe a -> Bool
    isJust Nothing = False
    isJust (Just _) = True

    isNothing :: Maybe a -> Bool
    isNothing = not . isJust

    fromMaybe :: a -> Maybe a -> a
    fromMaybe x Nothing = x
    fromMaybe x (Just y) = y

    listToMaybe :: [a] -> Maybe a
    listToMaybe [] = Nothing
    listToMaybe (x:xs) = Just x

    maybeToList :: Maybe a -> [a]
    maybeToList Nothing = []
    maybeToList (Just x) = [x]

    catMaybes :: [Maybe a] -> [a]
    catMaybes = map (\(Just x) -> x) . filter isJust

    flipMaybe :: [Maybe a] -> Maybe [a]
    flipMaybe = foldr fn (Just [])
        where
          fn :: Maybe a -> Maybe [a] -> Maybe [a]
          fn mx mxs = do
                  x <- mx
                  xs <- mxs
                  return $ x : xs
