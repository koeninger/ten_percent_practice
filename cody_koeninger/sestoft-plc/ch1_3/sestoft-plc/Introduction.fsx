type expr =
    | CstI of int
    | Var of string
    | Prim of string * expr * expr
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
    | Prim(op, e1, e2) ->
        let i1 = eval e1 env
        let i2 = eval e2 env
        match op with
        | "+" -> i1 + i2
        | "*" -> i1 * i2
        | "-" -> i1 - i2
        | "max" -> max i1 i2
        | "min" -> min i1 i2
        | "==" -> if i1 = i2 then 1 else 0
        | _ -> failwith "unknown primitive"
    | If(prd, thn, els) ->
        if (eval prd env) <> 0 then eval thn env else eval els env
        
let example1 = Prim("max", CstI 17, CstI 23)
let val1 = eval example1 emptyenv

let example2 = If(Prim("+", CstI 1, CstI -1), CstI 1, CstI 0)
let val2 = eval example2 emptyenv