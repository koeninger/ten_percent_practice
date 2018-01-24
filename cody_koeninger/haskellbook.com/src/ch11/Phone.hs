module Phone where
    import Data.Maybe (isJust)
    import Data.Char (isUpper, toLower)
    import Data.List (elemIndex, find, sort)
    import Debug.Trace (trace)
    import Text.Printf (printf)
        
    data DaPhone = DaPhone [(Char, [Char])] deriving Show
                 
    daPhone = DaPhone [
              ('1', "1"),
              ('2', "abc2"),
              ('3', "def3"),
              ('4', "ghi4"),
              ('5', "jkl5"),
              ('6', "mno6"),
              ('7', "pqrs7"),
              ('8', "tuv8"),
              ('9', "wxyz9"),
              ('*', "^*"),
              ('0', "+_0"),
              ('#', ".,#")
             ]


    convo :: [String]
    convo =[
         "Wanna play 20 questions",
         "Ya",
         "U 1st haha",
         "Lol ok. Have u ever tasted alcohol",
         "Lol ya",
         "Wow ur cool haha. Ur turn",
         "Ok. Do u think I am pretty Lol",
         "Lol ya",
         "Just making sure rofl ur turn"
        ]

    type Digit = Char

    type Presses = Int

    reverseTaps :: DaPhone -> Char -> [(Digit, Presses)]
    reverseTaps dp c =
        if (isUpper c)
        then ('*', 1) : reverseTaps dp (toLower c)
        else let DaPhone dps = dp
                 idxs = map (\(k, v) -> (k, elemIndex c v)) dps
                 found = find (\(k, v) -> isJust v) idxs
             in case found of
                  Just (k, Just i) -> [(k, i + 1)]
                  _ -> []
                       
    cellPhonesDead :: DaPhone -> String -> [(Digit, Presses)]
    cellPhonesDead d s = concat $ map (reverseTaps d) s

    fingerTaps :: [(Digit, Presses)] -> Presses
    fingerTaps = sum . map snd

    -- not total, fails on empty string
    mostPopularLetter :: String -> Char
    mostPopularLetter = mostPopular

    mostPopular :: (Eq a, Ord a) => [a] -> a
    mostPopular xs =
        let sorted = sort xs
            h = head sorted
            t = tail sorted
            recur win winCount cur curCount [] =
                if (curCount > winCount)
                then cur
                else win
            recur win winCount cur curCount (y:ys) =
                if (cur == y)
                then recur win winCount cur (curCount + 1) ys
                else if (curCount > winCount)
                     then recur cur curCount y 1 ys
                     else recur win winCount y 1 ys
        in recur h 1 h 1 t

    coolestLtr :: [String] -> Char
    coolestLtr = mostPopular . mostPopular

    coolestWord :: [String] -> String
    coolestWord = mostPopular
