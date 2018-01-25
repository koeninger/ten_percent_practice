notThe :: String -> Maybe String
notThe "the" = Nothing
notThe x = Just x

replaceThe :: String -> String
replaceThe xs =
    unwords $
    map (\x ->
         case x of
           Nothing -> "a"
           Just s -> s
        ) $
    map notThe $
    words xs

pointlessReplaceThe :: String -> String
pointlessReplaceThe =
    unwords .
    map (\x ->
         case x of
           Nothing -> "a"
           Just s -> s
        ) .
    map notThe .
    words
          
