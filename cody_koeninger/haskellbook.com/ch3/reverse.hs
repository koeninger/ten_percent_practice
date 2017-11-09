module Reverse where

    awe = "Curry is awesome"
       
    rvrs :: String -> String
    rvrs x = a ++ i ++ c
         where a = drop 9 x
               i = take 4 $ drop 5 x
               c = take 5 x

    main :: IO ()
    main = print $ rvrs awe
