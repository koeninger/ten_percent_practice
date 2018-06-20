#lang plai-typed

(require "plai.rkt")

(define fds (list))

(test (parse '(+ 23 42))
      (plusC (numC 23) (numC 42)))

(test (v*s-v (interp (numC 5) mt-env mt-store))
      (numV 5))

(test (v*s-v (interp (plusC (numC 23) (numC 42)) mt-env mt-store))
      (numV 65))

(test (v*s-v (interp (multC (numC 5) (numC 23)) mt-env mt-store))
      (numV 115))

(test (v*s-v (interp (parse '(if (+ 0 0) (* 1 2) (* 3 4))) mt-env mt-store))
      (numV 12))

(test (v*s-v (interp (parse '(if (+ 0 1) (* 1 2) (* 3 4))) mt-env mt-store))
      (numV 2))

 
(test (v*s-v (interp (appC (lamC 'x (appC (lamC 'y (plusC (varC 'x) (varC 'y)))
                                          (numC 4)))
                        (numC 3))
                  mt-env mt-store))
          (numV 7))

(test (v*s-v (interp
       (appC (appC (lamC 'x
                        (lamC 'y
                             (plusC (varC 'x) (varC 'y))))
                   (numC 4))
             (numC 5))
       mt-env mt-store))
      (numV 9))

(test/exn (v*s-v (interp
       (appC
        (appC (lamC 'f (lamC 'x (appC (varC 'f) (numC 10))))
              (lamC 'y (plusC (varC 'x) (varC 'y))))
        (numC 23))
       mt-env mt-store))
      "lookup: unbound identifier")

