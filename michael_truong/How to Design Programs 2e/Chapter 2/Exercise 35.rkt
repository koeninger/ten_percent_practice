#lang racket

; String -> String
; extracts the last character from a non-empty string (str)
; given:
;    "hi" for str
; expected:
;    "i"
(define (string-last str) (substring str (- (string-length str) 1)))