#! /usr/local/bin/racket
#lang racket

(define (string-first s)
  (substring s 0 1))

(string-first "hello world")
;(substring "hello world" 0 1) == "h"
