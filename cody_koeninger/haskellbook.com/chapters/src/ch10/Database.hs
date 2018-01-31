module Database where
    import Data.Time

    data DatabaseItem = DbString String
                      | DbNumber Integer
                      | DbDate UTCTime
                        deriving (Eq, Ord, Show)

    theDatabase :: [DatabaseItem]
    theDatabase =
        [ DbDate (UTCTime (fromGregorian 1911 5 1) (secondsToDiffTime 34123))
        , DbNumber 9001
        , DbString "Hello World"
        , DbDate (UTCTime (fromGregorian 1921 5 1) (secondsToDiffTime 34123))
        ]

    filterDbDate :: [DatabaseItem] -> [UTCTime]
    filterDbDate = foldr (\x acc -> case x of
                                      DbDate t -> t : acc
                                      _ -> acc
                         ) []

    filterDbNumber :: [DatabaseItem] -> [Integer]
    filterDbNumber = foldr (\x acc -> case x of
                                        DbNumber n -> n : acc
                                        _ -> acc
                           ) []

    mostRecent :: [DatabaseItem] -> UTCTime
    mostRecent = maximum . filterDbDate

    sumDb :: [DatabaseItem] -> Integer
    sumDb = sum . filterDbNumber

    avgDb :: [DatabaseItem] -> Double
    avgDb = uncurry (/) .
            foldr sumAndCount (0.0, 0) .
            filterDbNumber
            where
              sumAndCount x (s, c) = (s + fromIntegral x, c + 1)
