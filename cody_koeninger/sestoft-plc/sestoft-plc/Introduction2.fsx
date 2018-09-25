type expr =
    | CstI of int
    | Var of string
    | Add of expr * expr
    | Mul of expr * expr
    | Sub of expr * expr
    | Eql of expr * expr
    | If of expr * expr * expr

// association list for environment
let emptyenv = []

let rec lookup env x =
    match env with
    | [] -> failwith (x + " not found")
    | (y, v)::r -> if x=y then v else lookup r x

let rec eval (e : expr) (env : (string * int) list) : int =
    match e with
    | CstI i -> i
    | Var x -> lookup env x
    | Add(e1, e2) -> eval e1 env + eval e2 env
    | Mul(e1, e2) -> eval e1 env * eval e2 env
    | Sub(e1, e2) -> eval e1 env - eval e2 env
    | Eql(e1, e2) -> if (eval e1 env) = (eval e2 env) then 1 else 0
    | If(prd, thn, els) ->
        if (eval prd env) <> 0 then eval thn env else eval els env

let rec fmt (e : expr) : string =
    match e with
    | CstI i -> string i
    | Var x -> x
    | Add(e1, e2) -> sprintf "(%s + %s)" (fmt e1) (fmt e2)
    | Sub(e1, e2) -> sprintf "(%s - %s)" (fmt e1) (fmt e2)
    | Mul(e1, e2) -> sprintf "(%s * %s)" (fmt e1) (fmt e2)
    | Eql(e1, e2) -> sprintf "(%s == %s)" (fmt e1) (fmt e2)
    | If(prd, thn, els) -> sprintf "(if %s then %s else %s)" (fmt prd) (fmt thn) (fmt els)

let rec simplify (e: expr) : expr =
    match e with
    | Add(CstI 0, e) -> simplify e
    | Add(e, CstI 0) -> simplify e
    | Add(e, e2) -> simplify (Add(simplify e, simplify e2))
    | Sub(e, CstI 0) -> simplify e
    | Sub(e, e2) when e = e2 -> CstI 0
    | Sub(e, e2) -> simplify (Sub(simplify e, simplify e2))
    | Mul(CstI 1, e) -> simplify e
    | Mul(e, CstI 1) -> simplify e
    | Mul(CstI 0, e) -> CstI 0
    | Mul(e, CstI 0) -> CstI 0
    | Mul(e, e2) -> simplify (Mul(simplify e, simplify e2))
    | _ -> e

let rec fmtPrecedence (p: int) (e : expr) : string =
    match e with
    | CstI i -> string i
    | Var x -> x
    | Add(e1, e2) -> sprintf (if p >= 6 then "%s + %s" else "(%s + %s)")  (fmtPrecedence 6 e1) (fmtPrecedence 5 e2)
    | Sub(e1, e2) -> sprintf (if p >= 6 then "%s - %s" else "(%s - %s)") (fmtPrecedence 6 e1) (fmtPrecedence 5 e2)
    | Mul(e1, e2) -> sprintf (if p >= 5 then "%s * %s" else "(%s * %s)") (fmtPrecedence 5 e1) (fmtPrecedence 4 e2)
    | Eql(e1, e2) -> sprintf "(%s == %s)" (fmtPrecedence 10 e1) (fmtPrecedence 10 e2)
    | If(prd, thn, els) -> sprintf "(if %s then %s else %s)" (fmtPrecedence 0 prd) (fmtPrecedence 0 thn) (fmtPrecedence 0 els)


let example2 = If(Add(CstI 1, CstI -1), CstI 1, CstI 0)
let val2 = eval example2 emptyenv
let fullenv = [("v", 1); ("w", 2); ("x", 3); ("y", 4); ("z", 5)]
let example3 = Sub(Var "v", Add(Var "w", Var "z"))
let val3 = eval example3 fullenv
let example4 = Mul(CstI 2, (Sub(Var "v", Add(Var "w", Var "z"))))
let val4 = eval example4 fullenv
let fmt4 = fmt example4
let example5 = Add(Var "x", Add(Var "y", Add(Var "z", Var "v")))
let val5 = eval example5 fullenv
let example6 = Add(CstI 5, Sub(CstI 4, CstI 4))
let sim6 = simplify example6
let example7 = Mul(Add(CstI 1, CstI 0), Add(Var "x", CstI 0))
let sim7 = simplify example7
let example8 = Sub(Var "a", Sub(Var "b", Var "c"))
let pr8 = fmtPrecedence 10 example8
let example9 = Sub(Sub(Var "a", Var "b"), Var "c")
let pr9 = fmtPrecedence 10 example9
let example10 = Mul(Add(CstI 1, CstI 2), Add(CstI 3, CstI 4))
let pr10 = fmtPrecedence 10 example10