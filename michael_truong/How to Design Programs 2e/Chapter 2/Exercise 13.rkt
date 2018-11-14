#lang racket

(define (string-first str)
  (if (> (string-length str) 0)
      (substring str 0 1) ""))