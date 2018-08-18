#! /usr/local/bin/racket
#lang racket

(define a 3)
(define b 4)

(define (distance x y)
  (sqrt (+
    (sqr x) (sqr y)
  ))
)

(distance a b)
