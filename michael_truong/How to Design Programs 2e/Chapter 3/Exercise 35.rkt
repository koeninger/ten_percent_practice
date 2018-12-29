#lang racket

; String -> String
; extracts the last character from a non-empty string (str)
; given:
;    "hello_world" for str
; expected:
;    "d"

(define (string-last str)
  (cond
    [(> (string-length str) 0) (substring str (sub1 (string-length str)))]
    [else ""]))