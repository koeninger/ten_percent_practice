﻿type expr =
    | CstI of int
    | Var of string
    | Let of (string * expr) list * expr
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
    | Let((x, rhs)::rest, body) ->
        let xval = eval rhs env
        let env1 = (x, xval) :: env
        eval (Let(rest, body)) env1
    | Let([], body) ->
        eval body env
    | Add(e1, e2) -> eval e1 env + eval e2 env
    | Mul(e1, e2) -> eval e1 env * eval e2 env
    | Sub(e1, e2) -> eval e1 env - eval e2 env
    | Eql(e1, e2) -> if (eval e1 env) = (eval e2 env) then 1 else 0
    | If(prd, thn, els) ->
        if (eval prd env) <> 0 then eval thn env else eval els env

// exercise 2.1
let ex2_1 = eval (Let([("x1", Add(CstI 5, CstI 7)); ("x2", Mul(Var "x1", CstI 2))], Add(Var "x1", Var "x2"))) emptyenv

let rec closedin (e : expr) (vs : string list) : bool =
    match e with
    | CstI i -> true
    | Var x -> List.exists (fun y -> x=y) vs
    | Let((x, rhs)::rest, body) ->
        let vs1 = x :: vs
        closedin rhs vs && closedin (Let(rest, body)) vs1
    | Let([], body) -> closedin body vs
    | Add(e1, e2) -> closedin e1 vs && closedin e2 vs
    | Mul(e1, e2) -> closedin e1 vs && closedin e2 vs
    | Sub(e1, e2) -> closedin e1 vs && closedin e2 vs
    | Eql(e1, e2) -> closedin e1 vs && closedin e2 vs
    | If(prd, thn, els) -> closedin prd vs && closedin thn vs && closedin els vs

let closed1 e = closedin e emptyenv

let mem x ys = List.exists (fun y -> x=y) ys

let rec union xs ys =
    match xs with
    | [] -> ys
    | x::xr -> if mem x ys then union xr ys else x :: union xr ys

let rec minus xs ys =
    match xs with
    | [] -> []
    | x::xr -> if mem x ys then minus xr ys else x :: minus xr ys

let rec freevars e : string list =
    match e with
    | CstI i -> []
    | Var x -> [x]
    | Let((x, rhs)::rest, body) ->
        union (freevars rhs) (minus (freevars (Let(rest, body))) [x])
    | Let([], body) ->
        freevars body
    | Add(e1, e2) -> union (freevars e1) (freevars e2)
    | Sub(e1, e2) -> union (freevars e1) (freevars e2)
    | Mul(e1, e2) -> union (freevars e1) (freevars e2)
    | Eql(e1, e2) -> union (freevars e1) (freevars e2)
    | If(prd, thn, els) -> union (union (freevars prd) (freevars thn)) (freevars els)

let ex2_2 = freevars (Let([("x1", Add(Var "x1", CstI 7))], Add(Var "x1", CstI 8)))

let closed2 e = (freevars e = [])

let rec lookOrSelf env x =
    match env with
    | [] -> Var x
    | (y, e)::r -> if x=y then e else lookOrSelf r x

let rec remove env x =
    match env with
    | [] -> []
    | (y, e)::r -> if x=y then r else (y, e) :: remove r x


// assumes normal variable names don't end with numbers
let newVar : string -> string =
    let n = ref 0
    let varMaker x = (n := 1 + !n; x + string (!n))
    varMaker

let rec subst (e : expr) (env : (string * expr) list) : expr =
    match e with
    | CstI i -> e
    | Var x -> lookOrSelf env x
    | Let(xs, body) ->
        let (bs, env2) = substLetBindings xs env
        Let(bs, subst body env2)
    | Add(e1, e2) -> Add(subst e1 env, subst e2 env)
    | Sub(e1, e2) -> Sub(subst e1 env, subst e2 env)
    | Mul(e1, e2) -> Mul(subst e1 env, subst e2 env)
    | Eql(e1, e2) -> Eql(subst e1 env, subst e2 env)
    | If(prd, thn, els) -> If(subst prd env, subst thn env, subst els env)
and 
    substLetBindings (bs : (string * expr) list) (env : (string * expr) list) =
    match bs with
    | (x, rhs) :: rst ->
        let newx = newVar x
        let newenv = (x, Var newx) :: (remove env x)
        let rhs2 = subst rhs env
        let (rst2, env2) = substLetBindings rst newenv
        ((newx, rhs2) :: rst2, env2)
    | [] -> ([], env)

let e6 = Add(Var "y", Var "z")
let e9 = Let([("z",CstI 22)], Mul(Var "y",Var "z"))
let e9s3 = subst e9 [("y", Var "z")];;

// target expressions, with integer variable addresses
type texpr =
    | TCstI of int
    | TVar of int
    | TLet of texpr * texpr
    | TAdd of texpr * texpr
    | TMul of texpr * texpr
    | TSub of texpr * texpr
    | TEql of texpr * texpr
    | TIf of texpr * texpr * texpr

let rec tcomp (e : expr) (cenv : string list) : texpr =
    match e with
    | CstI i -> TCstI i
    | Var x -> TVar (List.findIndex (fun y -> y=x) cenv)
    | Let((x, rhs)::rst, body) ->
        let cenv1 = x :: cenv
        TLet(tcomp rhs cenv, tcomp (Let(rst, body)) cenv1)
    | Let([], body) -> tcomp body cenv
    | Add(e1, e2) -> TAdd(tcomp e1 cenv, tcomp e2 cenv)
    | Mul(e1, e2) -> TMul(tcomp e1 cenv, tcomp e2 cenv)
    | Sub(e1, e2) -> TSub(tcomp e1 cenv, tcomp e2 cenv)
    | Eql(e1, e2) -> TEql(tcomp e1 cenv, tcomp e2 cenv)
    | If(prd, thn, els) -> TIf(tcomp prd cenv, tcomp thn cenv, tcomp els cenv)

let rec teval (e : texpr) (renv : int list) : int =
    match e with
    | TCstI i -> i
    | TVar n -> List.item n renv
    | TLet(rhs, body) ->
        let xval = teval rhs renv
        let renv1 = xval :: renv
        teval body renv1
    | TAdd(e1, e2) -> teval e1 renv + teval e2 renv
    | TMul(e1, e2) -> teval e1 renv * teval e2 renv
    | TSub(e1, e2) -> teval e1 renv - teval e2 renv
    | TEql(e1, e2) -> if (teval e1 renv = teval e2 renv) then 1 else 0
    | TIf(prd, thn, els) -> if 0 <> teval prd renv then teval thn renv else teval els renv


// stack machine
type rinstr =
    | RCstI of int
    | RAdd
    | RSub
    | RMul
    | RDup
    | RSwap

let rec reval (inss : rinstr list) (stack : int list) : int =
    match (inss, stack) with
    | ([], v :: _) -> v
    | ([], []) -> failwith "reval: no result on stack"
    | (RCstI i :: insr, stk) -> reval insr (i :: stk)
    | (RAdd :: insr, i2 :: i1 :: stkr) -> reval insr ((i1 + i2) :: stkr)
    | (RSub :: insr, i2 :: i1 :: stkr) -> reval insr ((i1 - i2) :: stkr)
    | (RMul :: insr, i2 :: i1 :: stkr) -> reval insr ((i1 * i2) :: stkr)
    | (RDup :: insr, i1 :: stkr) -> reval insr (i1 :: i1 :: stkr)
    | (RSwap :: insr, i2 :: i1 :: stkr) -> reval insr (i1 :: i2 :: stkr)
    | _ -> failwith "reval: too few operands on stack"

type sinstr =
    | SCstI of int
    | SVar of int
    | SAdd
    | SSub
    | SMul
    | SPop
    | SSwap

// exercise 2.4 bytecode assembler
let assemble : sinstr list -> int list =
    List.collect (fun x ->
        match x with
        | SCstI i -> [0; i]
        | SVar x -> [1; x]
        | SAdd -> [2]
        | SSub -> [3]
        | SMul -> [4]
        | SPop -> [5]
        | SSwap -> [6]
    )

let exc2_4 = (assemble [SCstI 17; SVar 0; SVar 1; SAdd; SSwap; SPop] = [0; 17; 1; 0; 1; 1; 2; 6; 5])

let intsToFile (inss : int list) (fname : string) =
    let text = String.concat " " (List.map string inss)
    System.IO.File.WriteAllText(fname, text)


// exercise 2.6, simultaneous let bindings

let rec seval (e : expr) (env : (string * int) list) : int =
    match e with
    | CstI i -> i
    | Var x -> lookup env x
    | Let(binds, body) ->
        let binds1 = List.map (fun (x,r) -> (x, seval r env)) binds
        let env1 = List.append binds1 env
        seval body env1
    | Add(e1, e2) -> seval e1 env + seval e2 env
    | Mul(e1, e2) -> seval e1 env * seval e2 env
    | Sub(e1, e2) -> seval e1 env - seval e2 env
    | Eql(e1, e2) -> if (seval e1 env) = (seval e2 env) then 1 else 0
    | If(prd, thn, els) ->
        if (seval prd env) <> 0 then seval thn env else seval els env

let exc2_6 = seval (Let([("x", CstI 11)], Let([("x", CstI 22); ("y", Add(Var "x", CstI 1) )], Add(Var "x", Var "y")))) emptyenv


