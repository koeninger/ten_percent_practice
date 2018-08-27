;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex23) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define (string-first s)
  (substring s 0 1))
; I'm going to guess that it will grab the string, expand out a list of 1Strings, then add or append
;  together the range set by the other two arguments.  let's step:
(string-first "hello world")
; welp nope the stepper just shows the evalution of the substring funciton.  I guess system functions
;  are not stepped