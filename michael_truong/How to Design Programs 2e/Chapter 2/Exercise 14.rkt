#lang racket

(define (string-last str)
  (cond
    [(> (string-length str) 0) (substring str (sub1 (string-length str)))]
    [else str]))