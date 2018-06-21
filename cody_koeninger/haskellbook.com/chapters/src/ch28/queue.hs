import Criterion.Main

import qualified Data.Sequence as DS

data Queue a = Queue { enq :: [a], deq :: [a] }
  deriving (Eq, Show)

push :: a -> Queue a -> Queue a
push x q = Queue (x : enq q) (deq q)

pop :: Queue a -> Maybe (a, Queue a)
pop (Queue [] []) = Nothing
pop (Queue xs []) = pop (Queue [] (reverse xs))
pop (Queue e (x:xs)) = Just (x, Queue e xs)

pushS :: a -> DS.Seq a -> DS.Seq a
pushS x q = x DS.<| q

popS :: DS.Seq a -> Maybe (a, DS.Seq a)
popS xs = if (DS.null xs) then Nothing else Just (DS.index xs 0, DS.drop 1 xs)

makeQ xs = foldr (\x (Just (_,q)) -> pop $ push x q) (Just (head xs, Queue [] [])) xs

makeS xs = foldr (\x (Just (_,q)) -> popS $ pushS x q) (Just (head xs, DS.empty)) xs

myList :: [Int]
myList = [1..9999]

main :: IO ()
main = defaultMain
  [ bench "sequence"
    $ whnf makeS myList
  , bench "queue"
    $ whnf makeQ myList
  ]
