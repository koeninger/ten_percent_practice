#! /usr/local/bin/racket
#lang racket

; Data will be represented as a string
; String -> String
; Returns the last letter of the String s
; given: "Hello", expect: "o"
; given: "world", expect: "d"
(define (string-last s)
  (substring s (- (string-length s) 1)))

(string-last "Hello")
(string-last "world")
