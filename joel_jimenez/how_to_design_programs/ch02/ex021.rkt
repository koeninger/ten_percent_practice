#! /usr/local/bin/racket
#lang racket

(define (ff a) (* 10 a))
(ff (ff 1))

;(* 10 1) == 10
;(* 100 10) == 100
