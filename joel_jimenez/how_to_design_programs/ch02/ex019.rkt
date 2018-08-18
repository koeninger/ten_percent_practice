#! /usr/local/bin/racket
#lang racket

(define (string-join s1 s2)
  (string-append s1 "_" s2)
)

(define (string-insert str i)
  (define length (string-length str))
  (define s1 (substring str 0 i))
  (define s2 (substring str i length))
  (string-join s1 s2)
)

(string-insert "helloworld" 5)
(string-insert "" 0)
