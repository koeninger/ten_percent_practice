#lang racket

(define (distance x y)
  (sqrt (+ (expt x 2)
           (expt y 2))))