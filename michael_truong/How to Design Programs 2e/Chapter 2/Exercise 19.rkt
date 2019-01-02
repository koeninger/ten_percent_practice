#lang racket

(define (string-insert str i)
  (cond
    [(<= i (string-length str)) (string-append (substring str 0 i)
                                               "_"
                                               (substring str i))]
    [else str]))