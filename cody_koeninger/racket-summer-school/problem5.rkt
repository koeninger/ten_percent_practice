#lang racket

(require (for-syntax syntax/parse racket/list))

(define-syntax (define-rewrite-rule stx)
  (syntax-parse stx
    [(_ (f x ...) body)
     #'(define-syntax (f stx) (syntax-parse stx [(f x ...) #'body]))]))
     
(define-rewrite-rule
  (loop-for-ever exp)
  (local ((define (for-ever) (begin exp (for-ever))))
    (for-ever)))

(define-rewrite-rule (ident x) x)