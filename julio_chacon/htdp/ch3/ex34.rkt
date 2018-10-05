;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex34) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; string -> string
; extracts the first character from a string
; take str and take first character
; given: "test", expect : "t"
; given: "home", expect : "h"
(define (string-first str)
 (string-ith str 0))

