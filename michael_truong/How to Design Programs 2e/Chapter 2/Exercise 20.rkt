#lang racket

(define (string-delete str i)
  (cond
    [(and (> (string-length str) 0)
          (>= i 0)
          (< i (string-length str))) (string-append (substring str 0 i)
                                                    (substring str (add1 i)))]
    [else str]))