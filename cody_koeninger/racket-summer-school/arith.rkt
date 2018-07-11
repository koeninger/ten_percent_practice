#lang racket
(require (for-syntax syntax/parse))
 
(provide #%module-begin
         then
         else
         (rename-out [good-datum #%datum]
                     [plus +]
                     [my-if if]
                     [complain-app #%app]))

(define-syntax (my-if stx)
  (syntax-parse stx
;    #:datum-literals (then else)
    #:literals (then else)
    [(_ p:boolean then t:expr else f:expr)
     #'(if p t f)]))

(define-syntax (then stx)
  (raise-syntax-error 'arith "dont use then outside of if"))

(define-syntax (else stx)
  (raise-syntax-error 'arith "dont use else outside of if"))


(define-syntax (good-datum stx)
  (syntax-parse stx
    [(_ . v:number) #'(#%datum . v)]
    [(_ . s:string) #'(#%datum . s)]
    [(_ . b:boolean) #'(#%datum . b)]
    [(_ . other) (raise-syntax-error #f "not allowed" #'other)]))
 
(define-syntax (plus stx)
  (syntax-parse stx
   [(_ n1 n2) #'(+ n1 n2)]))
 
(define-syntax (complain-app stx)
  (define (complain msg src-stx)
    (raise-syntax-error 'parentheses msg src-stx))
  (define without-app-stx
    (syntax-parse stx [(_ e ...) (syntax/loc stx (e ...))]))
  (syntax-parse stx
   [(_)
    (complain "empty parentheses are not allowed" without-app-stx)]
   [(_ n:number)
    (complain "extra parentheses are not allowed around numbers" #'n)]
   [(_ x:id _ ...)
    (complain "unknown operator" #'x)]
   [_
    (complain "something is wrong here" without-app-stx)]))
