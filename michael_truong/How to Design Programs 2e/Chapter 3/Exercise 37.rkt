#lang racket

(define (string-rest str)
  (cond
    [(> (string-length str) 1) (substring str 1)]
    [else ""]))