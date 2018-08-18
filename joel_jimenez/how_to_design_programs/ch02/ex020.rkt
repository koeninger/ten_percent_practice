#! /usr/local/bin/racket
#lang racket

(define (string-delete str i)
  (if (> (string-length str) 0)
    (string-append
      (substring str 0 i)
      (substring str (+ i 1) (string-length str))
    )
  str)
)

(string-delete "hello_world" 5)
(string-delete "helloworld" 9)
(string-delete "helloworld" 0)
(string-delete "" 0)
