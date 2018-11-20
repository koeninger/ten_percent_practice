#lang racket

; String -> String
; extracts the first character from a non-empty string (str)
; given:
;    "hi" for str
; expected:
;    "h"
(define (string-first str) (substring str 0 1))