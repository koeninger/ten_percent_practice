#! /usr/local/bin/racket
#lang racket

(define str "helloworld")
(define i 0)

(string-append
  (substring str 0 i)
  (substring str (+ i 1) (string-length str))
)

; Which values for i are legitimate?
; From 0 to (string-length str)
