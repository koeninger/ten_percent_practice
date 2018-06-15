#lang racket/base

(require rackunit
         "plai.rkt")

(define fds (list))

(check-equal? (parse '(+ 23 42)) (plusC (numC 23) (numC 42)) "parse plus")

(check-equal? (interp (numC 5) fds) 5 "interp num")

(check-equal? (interp (plusC (numC 23) (numC 42)) fds) 65 "interp plus")

(check-equal? (interp (multC (numC 5) (numC 23)) fds) 115 "interp mult")

(check-equal? (interp (parse '(if (+ 0 0) (* 1 2) (* 3 4))) fds) 12 "interp if false")

(check-equal? (interp (parse '(if (+ 0 1) (* 1 2) (* 3 4))) fds) 2 "interp if true")