#lang racket

(define (cvolume length)
  (expt length 3))

(define (csurface length)
  (* 6 (sqr length)))