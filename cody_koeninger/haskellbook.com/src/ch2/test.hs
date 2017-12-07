sayHello :: String -> IO ()
sayHello x =
    putStrLn ("Hello " ++ x ++ "!")


half x = x / 2

square x = x * x

area r = pi * r ^ 2

double x = x * 2         

x = 7
y = 10
f = x + y

m1 = x * 3 + y
     where x = 5
           y = 6

m2 = x * 5
     where x = 10 * 5 + y
           y = 10

m3 = z / x + y
     where x = 7
           y = negate x
           z = y * 10

p1 = 2 + 2 * 3 - 1
p1p = (2 + (2 * 3)) - 1

p2 = (^) 10 $ 1 + 1
p2p = ((^) 10) $ (1 + 1)

p3 = 2 ^ 2 * 4 ^ 5 + 1
p3p = (2 ^ 2) * (4 ^ 5) + 1

waxOn = x * 5
        where z = 7
              x = y ^ 2
              y = z + 8

triple x = x * 3

waxOff x = triple x
