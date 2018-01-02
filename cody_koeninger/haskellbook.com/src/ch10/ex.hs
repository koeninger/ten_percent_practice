factorialNaive n = if (n < 1) then 1 else n * factorialNaive (n - 1)

factorialScan n =
    facts !! (n - 1) where
        facts = scanl (*) 1 [2..]
