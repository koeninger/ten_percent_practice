#! /usr/local/bin/racket
#lang racket

; Data will be represented as a String.
; String -> String
; Returns the first letter of String s
; given: "Hello", expect: "H"
; given: "world", expect: "w"
(define (string-first s)
  (substring s 0 1))

(string-first "Hello")
(string-first "world")
