#! /usr/local/bin/racket
#lang racket

(define (string-first s)
  (if (> (string-length s) 0)
    (substring s (- (string-length s) 1))
  s)
)

(string-first "apple")
(string-first "")
