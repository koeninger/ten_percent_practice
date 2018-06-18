#lang plai-typed

(require "plai.rkt")

(define fds (list))

(test (parse '(+ 23 42))
      (plusC (numC 23) (numC 42)))

(test (interp (numC 5) mt-env)
      (numV 5))

(test (interp (plusC (numC 23) (numC 42)) mt-env)
      (numV 65))

(test (interp (multC (numC 5) (numC 23)) mt-env)
      (numV 115))

(test (interp (parse '(if (+ 0 0) (* 1 2) (* 3 4))) mt-env)
      (numV 12))

(test (interp (parse '(if (+ 0 1) (* 1 2) (* 3 4))) mt-env)
      (numV 2))

 
(test (interp (appC (lamC 'x (appC (lamC 'y (plusC (idC 'x) (idC 'y)))
                                          (numC 4)))
                        (numC 3))
                  mt-env)
          (numV 7))

(test (interp
       (appC (appC (lamC 'x
                        (lamC 'y
                             (plusC (idC 'x) (idC 'y))))
                   (numC 4))
             (numC 5))
       mt-env)
      (numV 9))

(test/exn (interp
       (appC
        (appC (lamC 'f (lamC 'x (appC (idC 'f) (numC 10))))
              (lamC 'y (plusC (idC 'x) (idC 'y))))
        (numC 23))
       mt-env)
      "lookup: unbound identifier")