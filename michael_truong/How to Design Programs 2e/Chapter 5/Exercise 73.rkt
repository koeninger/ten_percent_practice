#lang racket

(require lang/posn)

(define (posn-up-x p n)
  (make-posn n (posn-y p)))