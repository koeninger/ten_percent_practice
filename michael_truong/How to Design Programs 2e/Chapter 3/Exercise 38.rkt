#lang racket

; String -> String
; produces a string like the given one (str) with the last character removed
; given:
;    "hello_world"
; expected:
;    "hello_worl"

(define (string-rest str)
  (cond
    [(> (string-length str) 0) (substring str 0 (sub1 (string-length str)))]
    [else ""]))