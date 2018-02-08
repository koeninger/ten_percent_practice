module Main where

    import Control.Monad (forever)
    import Data.Char (toLower)
    import Data.Maybe (isJust)
    import Data.List (intersperse)
    import System.Exit (exitSuccess)
    import System.Random (randomRIO)

    newtype WordList = WordList [String] deriving (Eq, Show)

    allWords :: IO WordList
    allWords = do
              dict <- readFile "data/dict.txt"
              return $ WordList (lines dict)

    minWordLength :: Int
    minWordLength = 5

    maxWordLength :: Int
    maxWordLength = 9

    gameWords :: IO WordList
    gameWords = do
          WordList aw <- allWords
          return $ WordList (filter gameLength aw)
          where gameLength w =
                    let l = length (w :: String)
                    in l >= minWordLength && l < maxWordLength

    randomWord :: WordList -> IO String
    randomWord (WordList wl) = do
              randomIndex <- randomRIO (0, length wl - 1)
              return $ wl !! randomIndex

    randomWord' :: IO String
    randomWord' = gameWords >>= randomWord

    -- word to guess, characters successfully filled in, characters guessed
    data Puzzle = Puzzle String [Maybe Char] [Char]

    instance Show Puzzle where
            show (Puzzle _ discovered guessed) =
                (intersperse ' ' $ fmap renderPuzzleChar discovered)
                ++ " Guessed so far " ++ guessed

    freshPuzzle :: String -> Puzzle
    freshPuzzle x = Puzzle x (fmap (const Nothing) x) []

    charInWord :: Puzzle -> Char -> Bool
    charInWord (Puzzle w _ _) c = elem c w

    alreadyGuessed :: Puzzle -> Char -> Bool
    alreadyGuessed (Puzzle _ _ g) c = elem c g

    renderPuzzleChar :: Maybe Char -> Char
    renderPuzzleChar (Just c) = c
    renderPuzzleChar Nothing = '_'

    fillInCharacter :: Puzzle -> Char -> Puzzle
    fillInCharacter (Puzzle word filled s) c =
        Puzzle word newFilled (c : s)
        where
          zipper guessed wordChar guessChar =
            if wordChar == guessed
            then Just wordChar
            else guessChar
          newFilled =
              zipWith (zipper c) word filled

    handleGuess :: Puzzle -> Char -> IO Puzzle
    handleGuess puzzle guess = do
              putStrLn $ "Your guess was: " ++ [guess]
              case (charInWord puzzle guess, alreadyGuessed puzzle guess) of
                (_, True) -> do
                  putStrLn "You already guessed that character, pick something else!"
                  return puzzle
                (True, _) -> do
                  putStrLn "Right!"
                  return (fillInCharacter puzzle guess)
                (False, _) -> do
                  putStrLn "Wrong!"
                  return (fillInCharacter puzzle guess)


    gameOver :: Puzzle -> IO ()
    gameOver (Puzzle wordToGuess _ guessed) =
        if (length guessed) > maxWordLength + 1 then
            do putStrLn "Too many guesses, You Lose!"
               putStrLn $ "The word was: " ++ wordToGuess
               exitSuccess
        else return()

    gameWin :: Puzzle -> IO ()
    gameWin (Puzzle _ filledInSoFar _) =
        if all isJust filledInSoFar then
            do putStrLn "A winner is you!"
               exitSuccess
        else return ()

    runGame :: Puzzle -> IO ()
    runGame puzzle = forever $ do
                       gameOver puzzle
                       gameWin puzzle
                       putStrLn $ "Current puzzle: " ++ show puzzle
                       putStrLn "Guess a letter: "
                       guess <- getLine
                       case guess of
                         [c] -> handleGuess puzzle c >>= runGame
                         _ -> putStrLn "Must guess a single character"
                   
    main :: IO ()
    main = do
      word <- randomWord'
      let puzzle = freshPuzzle (fmap toLower word)
      runGame puzzle
