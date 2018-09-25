;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex34) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; We use strings to represent words.
; String -> 1String
; Return the first character of x
; given: "Hello", expect: "H"
; given: "World", expect: "W"
(define (string-first x)
  (substring x 0 1))

(string-first "Hello")