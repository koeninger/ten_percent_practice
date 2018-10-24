module Exercise

let rec merge (xs : int list) (ys : int list) : int list =
    match (xs, ys) with
        | ((x::xr), (y::yr)) ->
            if (x < y) then x :: (merge xr ys) else y :: (merge xs yr)
        | ([], _) -> ys
        | (_, []) -> xs

assert ((merge [3;5;12] [2;3;4;7]) = [2;3;3;4;5;7;12])

let rec mergep (xs : 'a list) (ys : 'a list) (cmp : 'a -> 'a -> int) : 'a list =
    match (xs, ys) with
        | ((x::xr), (y::yr)) ->
            if ((cmp x y) < 0) then x :: (mergep xr ys cmp) else y :: (mergep xs yr cmp)
        | ([], _) -> ys
        | (_, []) -> xs

let icmp x y = if x < y then -1 else if x > y then 1 else 0

(* unnecessary, icmp will compare strings as well, but to be explicit *)
let scmp (x : string) (y : string) = if x < y then -1 else if x > y then 1 else 0

assert ((mergep [3;5;12] [2;3;4;7] icmp) = [2;3;3;4;5;7;12])

let ss1 = ["abc"; "apricot"; "ballad"; "zebra"]
let ss2 = ["abelian"; "ape"; "carbon"; "yosemite"]

assert ((mergep ss1 ss2 scmp) =   ["abc"; "abelian"; "ape"; "apricot"; "ballad"; "carbon"; "yosemite"; "zebra"])

let rec filter (p : 'a -> bool) (xs : 'a list) : 'a list =
    match xs with
        | x::xr ->
            if (p x) then x :: filter p xr else filter p xr
        | [] -> []

let rec forall (p : 'a -> bool) (xs : 'a list) : bool =
    match xs with
        | x::xr ->
            (p x) && forall p xr
        | [] -> true

let rec exists (p : 'a -> bool) (xs : 'a list) : bool =
    match xs with
        | x::xr ->
            (p x) || exists p xr
        | [] -> false

let rec mapPartial (f : 'a -> 'b option) (xs : 'a list) : 'b list =
    match xs with
        | x::xr ->
            match f x with
                | Some b -> b :: mapPartial f xr
                | None -> mapPartial f xr
        | [] -> []

type 'a tree =
    | Lf
    | Br of 'a * 'a tree * 'a tree

let rec treeFold f t e =
    match t with
        | Lf -> e
        | Br(v, t1, t2) -> f v (treeFold f t1 e) (treeFold f t2 e)

let count t = treeFold (fun x y z -> 1 + y + z) t 0

let sum t = treeFold (fun x y z -> x + y + z) t 0

let depth t = treeFold (fun x y z -> 1 + max y z) t 0

let preorder1 t = treeFold (fun x y z -> x :: y @ z) t []

let inorder1 t = treeFold (fun x y z -> y @ x :: z) t []

let postorder1 t = treeFold (fun x y z -> y @ z @ [x]) t []

let mapTree f t = treeFold (fun x y z -> Br(f x, y, z)) t Lf

let exampleT = Br(1, Br(2, Br(4, Lf, Lf), Br(5, Lf, Lf)), Br(3, Lf, Lf))
