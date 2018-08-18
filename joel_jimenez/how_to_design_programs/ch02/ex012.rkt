#! /usr/local/bin/racket
#lang racket

(define (csurface length)
  (sqr length)
)
(define (cvolume length)
  (* (csurface length) length)
)

(cvolume 3)
