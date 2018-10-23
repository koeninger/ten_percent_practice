module Exercise

let rec merge (xs : int list) (ys : int list) : int list =
    match (xs, ys) with
        | ((x::xr), (y::yr)) ->
            if (x < y) then x :: (merge xr ys) else y :: (merge xs yr)
        | ([], _) -> ys
        | (_, []) -> xs

assert ((merge [3;5;12] [2;3;4;7]) = [2;3;3;4;5;7;12])
