#lang racket

(define (string-delete str i)
  (if (> (string-length str) 0)
      (string-append (substring str 0 i)
                                   (substring str (+ i 1))) ""))