#! /usr/local/bin/racket
#lang racket

(define (==> sunny friday)
  (or (not sunny) friday)
)

(==> #false #false)
(==> #true #false)
(==> #false #true)
(==> #true #true)
