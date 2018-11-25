#lang racket

(define (string-first str)
  (cond
    [(> (string-length str) 0) (substring str 0 1)]
    [else ""]))