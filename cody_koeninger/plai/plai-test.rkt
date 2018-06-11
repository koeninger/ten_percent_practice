#lang racket/base

(require rackunit
         "plai.rkt")

(check-equal? (parse '(+ 23 42)) (plusC (numC 23) (numC 42)) "parse plus")

(check-equal? (interp (numC 5)) 5 "interp num")

(check-equal? (interp (plusC (numC 23) (numC 42))) 65 "interp plus")

(check-equal? (interp (multC (numC 5) (numC 23))) 115 "interp mult")
