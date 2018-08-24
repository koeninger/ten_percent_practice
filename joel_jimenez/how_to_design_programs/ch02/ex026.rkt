#! /usr/local/bin/racket
#lang racket

(define (string-insert s i)
  (string-append (substring s 0 i)
    "_"
    (substring s i)))

(string-insert "helloworld" 6)

;(substring "helloworld" 0 6) == "hellow"
;(substring "helloworld" 6) == "orld"
;(string-append "hellow" "_" "orld") == "hellow_orld"
