#lang racket
(require (for-syntax syntax/parse racket/list))

(module reader syntax/module-reader simple)

(provide #%module-begin
         define-function
         function-app
         (rename-out [literal #%datum]
                     [my-if if]
                     [complain-app #%app]))

(define-syntax (literal stx)
  (syntax-parse stx
    [(_ . s:string) #'(quote s)]
    [(_ . n:number) #'(#%datum . n)]
    [(_ . other)
     (raise-syntax-error
      'simple
      "you can only write numbers or strings"
      #'other)]))

; Works but zero points
#;
(define-syntax (op stx)
  (syntax-parse stx
   #:datum-literals (+ - / *)
   [(+ n1 n2) #`(+ n1 n2)]
   [(- n1 n2) #`(- n1 n2)]
   [(/ n1 n2) #`(/ n1 n2)]
   [(* n1 n2) #`(* n1 n2)]
    ))

(define-syntax (make-operator stx)
  (syntax-parse stx
    ([_ operator]  
#'(begin
    (define-syntax (op stx)
      (syntax-parse stx
        [(o n1 n2) #`(#,operator n1 n2)]))
    (provide (rename-out [op operator]))))))
(make-operator +)
(make-operator -)
(make-operator /)
(make-operator *)

    
#;
(define-syntax (op stx)
  (define ids (syntax->list stx))
  (define operation (first ids))
  (define operands (rest ids))
  #`(#,operation #,@operands))
 
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


(define-syntax (define-function stx)
  (syntax-parse stx
    [(_ (function-name:id parameter:id ...) body:expr)
     (define arity (length (syntax->list #'(parameter ...))))
     #`(define-syntax function-name
         (cons #,arity #'(lambda (parameter ...) body)))]))

(define-syntax (function-app stx)
  (syntax-parse stx
    [(_ function-name:id argument:expr ...)
     #:do ((define-values (arity function) (lookup #'function-name)))
     #:fail-unless (= arity (length (syntax->list #'(argument ...))))
     "wrong number of arguments"
     
     #`(#,function argument ...)]))

(define-for-syntax (lookup function-name)
  (define x (syntax-local-value function-name))
  (values (car x) (cdr x)))


(define-syntax (my-if stx)
  (syntax-parse stx
    [(_ p:expr then:expr else:expr)
    #'(if p then else)]))

#;
(define-syntax f (cons 2 #'(lambda (x y) (+ x y))))
#;
(define-function (f x y ) (+ x y ))
#;
(function-app f 1 2)
#;
(define-function (g x)
  (if (zero? x)
      1
      (function-app g 0)))
#;
(function-app g 1)
           
