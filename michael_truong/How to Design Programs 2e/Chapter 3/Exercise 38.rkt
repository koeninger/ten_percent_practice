#lang racket

(define (string-remove-last str)
  (cond
    [(> (string-length str) 0) (substring str 0 (sub1 (string-length str)))]
    [else str]))