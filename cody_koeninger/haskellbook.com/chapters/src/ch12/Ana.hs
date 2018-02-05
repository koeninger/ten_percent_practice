module Ana where

    import BinaryTree
        
    myIterate :: (a -> a) -> a -> [a]
    myIterate fn z = z : myIterate fn (fn z)

    myUnfoldr :: (b -> Maybe (a, b)) -> b -> [a]
    myUnfoldr fn z =
        case fn z of
          Just (x, y) -> x : myUnfoldr fn y
          Nothing -> []

    betterIterate :: (a -> a) -> a -> [a]
    betterIterate fn z = myUnfoldr (\x -> Just (x, fn x)) z

    unfold :: (a -> Maybe (a, b, a)) -> a -> BinaryTree b
    unfold fn z =
        case fn z of
          Just (l, v, r) -> Node (unfold fn l) v (unfold fn r)
          Nothing -> Leaf


    treeBuild :: Integer -> BinaryTree Integer
    treeBuild n = unfold (\x -> if x >= n then Nothing else Just (x + 1, x, x + 1)) 0
