#! /usr/local/bin/racket
#lang racket
(+ 1 1)

(+ 2 2)
(* 3 3)
(- 4 2)
(/ 6 2)

(sqr 3)
(expt 2 3)
(sin 0)
(cos pi)

( + 2 (+ 3 4))
( + 2 3 4)

(string-append "Hello" " " "World")
(+ (string-length "Hello world") 20)
(number->string 42)
(string->number "42")
(string->number "hello world")

(and #true #true)
(and #true #false)
(or #false #true)
(or #false #false)
(not #true)

(> 10 9)
(< -1 0)
(= 42 9)
(>= 10 10)
(<= -1 0)
(string=? "design" "tinker")

(and (or (= (string-length "hello world")
            (string->number "11"))
         (string=? "hello world" "good morning"))
     (>= (+ (string-length "hello world") 60) 80))

(require 2htdp/image)
(circle 10 "solid" "red")
(rectangle 30 20 "outline" " blue")
(overlay (rectangle 20 20 "solid" " blue")
  (circle 5 "solid" "red"))

(define (y x) (* x x))
(y 1)
(y 2)
(y 3)
(y 4)
(y 5)
