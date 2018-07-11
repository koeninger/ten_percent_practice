#lang racket
(require (for-syntax syntax/parse racket/list))

(module reader syntax/module-reader
  algebra
  #:wrapper1 (lambda (t)
               (parameterize ([read-decimal-as-inexact #f])
                 (t))))

(provide #%module-begin
         define-function
         function-app
         exactly
         inexactly
         (rename-out [literal #%datum]
                     [my-if if]
                     [complain-app #%app]))

(define-for-syntax exacting #f)

(define-syntax (exactly stx)
  (syntax-parse stx
    [(_ e:expr)
     (begin
       (set! exacting #t)
       #'e)]))


(define-syntax (inexactly stx)
  (syntax-parse stx
    [(_ e:expr)
     (begin
       (set! exacting #f)
       #'e)]))

(define-syntax (literal stx)
  (syntax-parse stx
    [(_ . s:string) #'(quote s)]
    [(_ . n:number) (let ((num ((if exacting inexact->exact exact->inexact)
                                (syntax-e #'n))))
                      #`(#%datum . #,num))]
    [(_ . other)
     (raise-syntax-error
      'simple
      "you can only write numbers or strings"
      #'other)]))


(define-syntax (make-operator stx)
  (syntax-parse stx
    ([_ (opname opfn) ...]  
     #'(begin
         (begin
           (define-syntax (opname stx)
             (syntax-parse stx
               [(o n1 n2) #`(#,opfn n1 n2)]))
           (provide (rename-out [opname opfn]) )) ...))))

(make-operator
 (plus +)
 (minus -)
 (mult *)
 (div /)
 (gt >)
 (gte >=))
    
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
