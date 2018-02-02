module BinaryTree where

data BinaryTree a = Leaf
                  | Node (BinaryTree a) a (BinaryTree a) deriving (Eq, Ord, Show)

insert' :: Ord a => a -> BinaryTree a -> BinaryTree a
insert' a Leaf = Node Leaf a Leaf
insert' a (Node l a' r) = if (a < a')
                        then Node (insert' a l) a' r
                        else Node l a' (insert' a r)
                             
myTree = insert' 66 $ insert' 12 $ insert' 42 $ insert' 23 Leaf
                             
instance Functor BinaryTree where
    fmap f Leaf = Leaf
    fmap f (Node l a r) = Node (fmap f l) (f a) (fmap f r)


preorder :: BinaryTree a -> [a]
preorder Leaf = []
preorder (Node l a r) = [a] ++ preorder l ++ preorder r

postorder :: BinaryTree a -> [a]                      
postorder Leaf = []
postorder (Node l a r) = postorder l ++ postorder r ++ [a]

inorder :: BinaryTree a -> [a]
inorder Leaf = []
inorder (Node l a r) = inorder l ++ [a] ++ inorder r
                       
testTree :: BinaryTree Integer
testTree =
    Node (Node Leaf 1 Leaf) 2 (Node Leaf 3 Leaf)
             
testPreorder :: IO ()
testPreorder =
    if preorder testTree == [2, 1, 3]
    then putStrLn "Preorder fine!"
    else putStrLn "Bad news bears."

testInorder :: IO ()
testInorder =
    if inorder testTree == [1, 2, 3]
    then putStrLn "Inorder fine!"
    else putStrLn "Bad news bears."

testPostorder :: IO ()
testPostorder =
    if postorder testTree == [1, 3, 2]
    then putStrLn "Postorder fine!"
    else putStrLn "postorder failed check"

main :: IO ()
main = do
  testPreorder
  testInorder
  testPostorder

foldTree :: (a -> b -> b) -> b -> BinaryTree a -> b
foldTree f z Leaf = z
foldTree f z (Node l a r) =
    let lhs = foldTree f z l
    in f a (foldTree f lhs r)
            
