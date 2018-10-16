(* Fun/Absyn.fs * Abstract syntax for micro-ML, a functional language *)

module Absyn

type expr = 
  | CstI of int
  | CstB of bool
  | Var of string
  | Let of string * expr * expr
  | Prim of string * expr * expr
  | If of expr * expr * expr
  | Letfun of string * string list * expr * expr    (* (f, x y z, fBody, letBody) *)
  | Call of expr * expr list
  | Tup of expr list
  | Sel of int * expr
  | CstN
  | ConC of expr * expr
  | Match of expr * expr * (string * string * expr)
