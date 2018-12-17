#lang racket

(define-struct 3String [c1 c2 c3])

(define (compare-char c1 c2)
  (cond
    [(string=? c1 c2) c1]
    [else #false]))

(define (compare-word str1 str2)
  (make-3String (compare-char (3String-c1 str1) (3String-c1 str2)) (compare-char (3String-c2 str1) (3String-c2 str2)) (compare-char (3String-c3 str1) (3String-c3 str2))))