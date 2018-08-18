#! /usr/local/bin/racket
#lang racket

(define (string-first s)
  (if (> (string-length s) 0)
    (substring s 0 1)
  s)
)

(string-first "apple")
(string-first "")
