#lang racket

; String -> String
; extracts the first character from a non-empty string (str)
; given:
;    "hello_world" for str
; expected:
;    "h"
(define (string-first str) (if (> (string-length str) 0)(substring str 0 1) ""))