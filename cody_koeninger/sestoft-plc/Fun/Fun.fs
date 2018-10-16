(* File Fun/Fun.fs
   A strict functional language with integers and first-order 
   one-argument functions * sestoft@itu.dk

   Does not support mutually recursive function bindings.

   Performs tail recursion in constant space (because F# does).
*)

module Fun

open Absyn

(* Environment operations *)

type 'v env = (string * 'v) list

let rec lookup env x =
    match env with 
    | []        -> failwith (x + " not found")
    | (y, v)::r -> if x=y then v else lookup r x;;

(* A runtime value is an integer or a function closure *)

type value = 
  | Int of int
  | TupV of value list
  | ListV of value list
  | Closure of string * string list * expr * value env       (* (f, x y z, fBody, fDeclEnv) *)

let rec eval (e : expr) (env : value env) : value =
    match e with 
    | CstI i -> Int i
    | CstB b -> Int (if b then 1 else 0)
    | Var x  ->
      match lookup env x with
      | Int i -> Int i
      | TupV xs -> TupV xs
      | ListV xs -> ListV xs
      | _     -> failwith (sprintf "eval Var doesn't allow closures %A" x)
    | Prim(ope, e1, e2) -> 
      let i1 =
          match eval e1 env with
          | Int i -> i
          | _ -> failwith (sprintf "eval not an int Prim(%A %A %A)" ope e1 e2)
      let i2 =
          match eval e2 env with
          | Int i -> i
          | _ -> failwith (sprintf "eval not an int Prim(%A %A %A)" ope e1 e2)
      match ope with
      | "*" -> i1 * i2
      | "+" -> i1 + i2
      | "-" -> i1 - i2
      | "=" -> if i1 = i2 then 1 else 0
      | "<" -> if i1 < i2 then 1 else 0
      | "<=" -> if i1 <= i2 then 1 else 0
      | ">" -> if i1 > i2 then 1 else 0
      | ">=" -> if i1 >= i2 then 1 else 0
      | _   -> failwith ("unknown primitive " + ope)
      |> Int
    | Let(x, eRhs, letBody) -> 
      let xVal = eval eRhs env
      let bodyEnv = (x, xVal) :: env
      eval letBody bodyEnv
    | If(e1, e2, e3) -> 
      match eval e1 env with
      | Int b -> if b<>0 then eval e2 env else eval e3 env
      | x -> failwith (sprintf "First argument to if was not a bool / int: %A" x)
    | Letfun(f, xs, fBody, letBody) -> 
      let bodyEnv = (f, Closure(f, xs, fBody, env)) :: env 
      eval letBody bodyEnv
    | Call(Var f, eArgs) -> 
      let fClosure = lookup env f
      match fClosure with
      | Closure (f, xs, fBody, fDeclEnv) ->
        let xVals = List.zip xs eArgs |> List.map (function | (x, e) -> (x, eval e env))
        let fBodyEnv = xVals @ (f, fClosure) :: fDeclEnv
        eval fBody fBodyEnv
      | _ -> failwith "eval Call: not a function"
    | Call _ -> failwith "eval Call: not first-order function"
    | Tup xs -> List.map (fun x -> eval x env) xs |> TupV
    | Sel(i, v) ->
        match eval v env with
        | TupV xs -> List.item (i - 1) xs 
        | e -> failwith (sprintf "eval Sel: expected a tuple, got %A" e)
    | CstN -> ListV []
    | ConC(e1, e2) ->
        let e1val = eval e1 env
        let e2val = eval e2 env
        match e2val with
            | ListV xs -> ListV (e1val :: xs)
            | e -> failwith (sprintf "eval ConC: expected a list, got %A" e)
    | Match(e0, e1, (h, t, e2)) ->
        match eval e0 env with
            | ListV [] -> eval e1 env
            | ListV (hx::tx) ->
                let newEnv = (h, hx) :: (t, ListV tx) :: env
                eval e2 newEnv
            | e -> failwith (sprintf "eval Match: expected a list, got %A" e)

(* Evaluate in empty environment: program must have no free variables: *)

let run e = eval e [];;

(* Examples in abstract syntax *)

let ex1 = Letfun("f1", ["x"], Prim("+", Var "x", CstI 1), 
                 Call(Var "f1", [CstI 12]));;

(* Example: factorial *)

let ex2 = Letfun("fac", ["x"],
                 If(Prim("=", Var "x", CstI 0),
                    CstI 1,
                    Prim("*", Var "x", 
                              Call(Var "fac", 
                                   [Prim("-", Var "x", CstI 1)]))),
                 Call(Var "fac", [Var "n"]));;

(* let fac10 = eval ex2 [("n", Int 10)];; *)

(* Example: deep recursion to check for constant-space tail recursion *)

let ex3 = Letfun("deep", ["x"], 
                 If(Prim("=", Var "x", CstI 0),
                    CstI 1,
                    Call(Var "deep", [Prim("-", Var "x", CstI 1)])),
                 Call(Var "deep", [Var "count"]));;
    
let rundeep n = eval ex3 [("count", Int n)];;

(* Example: static scope (result 14) or dynamic scope (result 25) *)

let ex4 =
    Let("y", CstI 11,
        Letfun("f", ["x"], Prim("+", Var "x", Var "y"),
               Let("y", CstI 22, Call(Var "f", [CstI 3]))));;

(* Example: two function definitions: a comparison and Fibonacci *)

let ex5 = 
    Letfun("ge2", ["x"], Prim("<", CstI 1, Var "x"),
           Letfun("fib", ["n"],
                  If(Call(Var "ge2", [Var "n"]),
                     Prim("+",
                          Call(Var "fib", [Prim("-", Var "n", CstI 1)]),
                          Call(Var "fib", [Prim("-", Var "n", CstI 2)])),
                     CstI 1), Call(Var "fib", [CstI 25])));;

let ex6 =
    Letfun("sum", ["xs"], Match(Var "xs", CstI 0, ("hd", "tl", (Prim("+", Var "hd", Call(Var "sum", [Var "tl"]))))),
           Call(Var "sum", [ConC(CstI 1, ConC(CstI 2, CstN))]));;
