import System.Random

data Die
  = DieOne
  | DieTwo
  | DieThree
  | DieFour
  | DieFive
  | DieSix
  deriving (Eq, Show)

intToDie :: Int -> Die
intToDie n = case n of
  1 -> DieOne
  2 -> DieTwo
  3 -> DieThree
  4 -> DieFour
  5 -> DieFive
  6 -> DieSix
  _ -> error $ "bad die integer " ++ show n

rollsToGetN :: Int -> StdGen -> Int
rollsToGetN n g = go 0 0 g
  where
    go :: Int -> Int -> StdGen -> Int
    go sum count gen
      | sum >= n = count
      | otherwise =
        let (die, nextGen) = randomR (1, 6) gen
        in go (sum + die) (count + 1) nextGen

rollsCountLogged :: Int -> StdGen -> (Int, [Die])
rollsCountLogged n g = reverse <$> go 0 0 g []
  where
    go :: Int -> Int -> StdGen -> [Die] -> (Int, [Die])
    go sum count gen log
      | sum >= n = (count, log)
      | otherwise =
        let (die, nextGen) = randomR (1, 6) gen
        in go (sum + die) (count + 1) nextGen ((intToDie die) : log)
