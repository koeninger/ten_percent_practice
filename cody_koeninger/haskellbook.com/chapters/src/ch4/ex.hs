data Mood = Blah | Woot deriving Show

changeMood :: Mood -> Mood
changeMood Blah = Woot
changeMood Woot = Blah

x = 23
x1 = not True && True
x2 = not (x == 6)
x3 = (1 * 2) > 5
x4 = "Merry" > "Happy"
x5 = ['1', '2', '3'] ++ "look at me!"



awesome = ["Papuchon", "curry", ":)"]
also = ["Quake", "The Simons"]
allAwesome = [awesome, also]

len :: [a] -> Int
len [] = 0
len (x:xs) = 1 + len xs

q3 = 6 `div` length [1, 2, 3]

q4 = 2 + 3 == 5

isPalindrome :: Eq a => [a] -> Bool
isPalindrome xs = reverse xs == xs


myAbs :: Integer -> Integer
myAbs x = if x >= 0 then x else -x

f :: (a, b) -> (c, d) -> ((b, d), (a, c))
f (a, b) (c, d) = ((b, d), (a, c))

