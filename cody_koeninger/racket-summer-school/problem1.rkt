#lang racket

(require (for-syntax syntax/parse racket/list))


(define-syntax (define-world* stx)
  (do-define-world2 (rest (syntax->list stx))))
  
(define-for-syntax
  (do-define-world i xs)
  (if (cons? xs)
      #`(begin (define #,(first xs) #,i)
           #,(do-define-world (add1 i) (rest xs)))
      #'(begin)))

(define-for-syntax
  (do-define-world2 xs)
  (define-values (_ ds) (for/fold ( [i 0] [ds '()])
            ([x xs])
    (values (add1 i) (cons #`(define #,x #,i) ds))))
  #`(begin #,@ds))

(define-world*)
(define-world* x)
(displayln x)
(define-world* a b c)
(displayln (list a b c))



