#lang racket

(define (string-last str)
  (cond
    [(> (string-length str) 0) (substring str (- (string-length str) 1))]
    [else ""]))