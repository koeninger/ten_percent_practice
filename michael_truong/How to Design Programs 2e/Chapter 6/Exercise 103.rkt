#lang racket

(define-struct spider [legs space])
(define-struct elephant [space])
(define-struct boa-constrictor [length girth])
(define-struct armadillo [space])

(define (animal-space ani)
  (cond
    [(spider? ani) (spider-space ani)]
    [(elephant? ani) (elephant-space ani)]
    [(boa-constrictor? ani) (* (boa-constrictor-length ani)
                               (boa-constrictor-girth ani))]
    [(armadillo? ani) (armadillo-space ani)]
    [else -1]))

(define (fits? ani cage)
  (<= (animal-space ani) cage))