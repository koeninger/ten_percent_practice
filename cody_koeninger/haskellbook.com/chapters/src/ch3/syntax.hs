s1 = (++) [1,2,3][4,5,6]

s2 = "<3" ++ "Haskell"

s3 = concat ["<3", "Haskell"]

rs1a = concat [[1,2,3],[4,5,6]]

rs1b = (++) [1,2,3][4,5,6]

rs1c = (++) "hello" " world"

rs1d = "hello" ++ " world"

rs1e = "hello" !! 4

rs1f = (!!) "hello" 4

rs1g = take 4 "lovely"

rs1h = take 3 "awesome"

awe = "Curry is awesome"
       
bf1a xs = xs ++ "!"

bf1b xs = xs !! 4

bf1c xs = drop 9 xs

thirdLetter :: String -> Char
thirdLetter xs = xs !! 2

letterIndex :: Int -> Char
letterIndex x = awe !! x

rvrs :: String -> String
rvrs x = a ++ i ++ c
         where a = drop 9 x
               i = take 4 $ drop 5 x
               c = take 5 x
