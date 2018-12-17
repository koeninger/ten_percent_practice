#lang racket

; String -> String
; produces a string like the given one (str) with the first character removed
; given:
;    "hello_world"
; expected:
;    "ello_world"

(define (string-rest str)
  (cond
    [(> (string-length str) 1) (substring str 1)]
    [else ""]))