#! /usr/local/bin/racket
#lang racket

(define (==> x y)
  (or (not x) y))

(==> #true #false)
;(not #true) == #false
;(or #false #false) == #false
