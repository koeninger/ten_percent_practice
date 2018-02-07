data TisAnInteger = TisAn Integer

instance Eq TisAnInteger where
    (==) (TisAn x) (TisAn y) = x == y

data TwoIntegers = Two Integer Integer

instance Eq TwoIntegers where
    (==) (Two x y) (Two a b) = x == a && y == b


data StringOrInt =
    TisAnInt Int
    | TisAString String

instance Eq StringOrInt where
    (==) (TisAnInt x) (TisAnInt y) = x == y
    (==) (TisAString x) (TisAString y) = x == y
    (==) _ _ = False

data Pair a = Pair a a deriving Show

instance (Eq a) => Eq (Pair a) where
    (==) (Pair x y) (Pair a b) = x == a && y == b

data Tuple a b = Tuple a b

instance (Eq a, Eq b) => Eq (Tuple a b) where
    (==) (Tuple x y) (Tuple a b) = x == a && y == b

data Which a =
    ThisOne a
    | ThatOne a

instance (Eq a) => Eq (Which a) where
    (==) (ThisOne x) (ThisOne y) = x == y
    (==) (ThatOne x) (ThatOne y) = x == y
    (==) _ _ = False

data EitherOr a b =
    Hello a
    | Goodbye b

instance (Eq a, Eq b) => Eq (EitherOr a b) where
    (==) (Hello x) (Hello y) = x == y
    (==) (Goodbye x) (Goodbye y) = x == y
    (==) (Goodbye _) (Hello _) = False
    (==) (Hello _) (Goodbye _) = False
