#lang racket

(define (string-delete str i)
  (cond
    [(and (> (string-length str) 0)
          (and (>= i 0)
               (< i (string-length str)))) (string-append (substring str 0 i)
                                                          (substring str (+ i 1)))]
    [else str]))