import System.Random
import Control.Monad
import qualified Control.Monad.Trans.State as TS

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

newtype State s a = State { runState :: s -> (a, s) }

instance Functor (State s) where
  fmap f (State g) = State $ \s ->
    let (a, s2) = g s
    in (f a, s2)

instance Applicative (State s) where
  pure a = State $ \s ->
    (a, s)

  (State f) <*> (State g) = State $ \s ->
    let (fab, s2) = f s
        (a, s3) = g s2
    in (fab a, s3)

instance Monad (State s) where
  return = pure

  (State f) >>= g = State $ \s ->
    let (a, s2) = f s
        State h = g a
    in h s2


fizzbuzz :: Integer -> String
fizzbuzz n | mod n 15 == 0 = "fizzbuzz"
           | mod n 3 == 0 = "fizz"
           | mod n 5 == 0 = "buzz"
           | otherwise = show n

fizzbuzzFromTo :: Integer -> Integer -> [String]
fizzbuzzFromTo from to =
  TS.execState (mapM_ addResult (enumFromThenTo to (to - 1) from)) []

addResult :: Integer -> TS.State [String] ()
addResult n = do
  xs <- TS.get
  let result = fizzbuzz n
  TS.put (result : xs)

get :: State s s
get = State $ \s -> (s, s)

put :: s -> State s ()
put s = State $ \_ -> ((), s)

exec :: State s a -> s -> s
exec (State sa) s = snd $ sa s

eval :: State s a -> s -> a
eval (State sa) s = fst $ sa s

modify :: (s -> s) -> State s ()
modify fn = State $ \s -> ((), fn s)
