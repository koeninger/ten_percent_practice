module Phone where
    import Data.Maybe (isJust)
    import Data.Char (isUpper, toLower)
    import Data.List (elemIndex, find)
        
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
                       
