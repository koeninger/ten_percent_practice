(* Fun/Absyn.fs * Abstract syntax for micro-ML, a functional language *)

module Absyn

type expr = 
  | CstI of int
  | CstB of bool
  | Var of string
  | Let of string * expr * expr
  | Prim of string * expr * expr
  | If of expr * expr * expr
  | Letfun of fundef list * expr
  | Call of expr * expr list
  | Tup of expr list
  | Sel of int * expr
  | CstN
  | ConC of expr * expr
  | Match of expr * expr * (string * string * expr)
and fundef = string * string list * expr   (* (f, x y z, fBody) *)
