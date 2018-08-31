#! /usr/local/bin/racket
#lang racket

; Data will be represented as a String.
; String -> String
; Returns String s without the first letter
; given: "Hello", expect: "ello"
; given: "world", expect: "orld"
(define (string-rest s)
  (substring s 1))

(string-rest "Hello")
(string-rest "world")
