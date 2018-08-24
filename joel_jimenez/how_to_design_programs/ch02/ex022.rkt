#! /usr/local/bin/racket
#lang racket

(define (distance-to-origin x y)
  (sqrt (+ (sqr x) (sqr y))))

(distance-to-origin 3 4)
;(sqr 3) == 9
;(sqr 4) == 16
;(+ 9 16) == 25
;(sqrt 25) == 5
