module Cipher where

    import Data.Char

    caesar :: Int -> [Char] -> [Char]
    caesar shift string = map (changeChar shift) string

    changeChar :: Int -> Char -> Char
    changeChar shift c =
        if (('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z'))
        then
            let start = if (isUpper c) then ord 'A' else ord 'a'
                distance = mod (ord c - start + shift) 26
            in chr (start + distance)
        else c
             
    unCaesar :: Int -> [Char] -> [Char]
    unCaesar shift string = caesar (- shift) string
