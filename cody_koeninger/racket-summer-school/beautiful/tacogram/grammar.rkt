#lang brag

taco-program : taco-leaf+
taco-leaf : [/"\n"] /"#" bit{7} /"$" [/"\n"]
@bit : not-a-taco | taco
not-a-taco : /("#" "$")
taco : /"%"
