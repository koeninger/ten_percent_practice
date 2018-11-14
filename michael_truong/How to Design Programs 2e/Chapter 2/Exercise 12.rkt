#lang racket

(define (cvolume length) (expt length 3))
(define (csurface length) (* (expt length 2) 6))