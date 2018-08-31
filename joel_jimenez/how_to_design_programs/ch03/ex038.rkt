#! /usr/local/bin/racket
#lang racket

; Data will be represented as a string
; String -> String
; Returns the String s without the last letter
; given: "Hello", expect: "Hell"
; given: "world", expect: "worl"
(define (string-remove-last s)
  (substring s 0 (- (string-length s) 1)))

(string-remove-last "Hello")
(string-remove-last "world")
