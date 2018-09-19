;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03_34) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 34. Design the function string-first,
; which extracts the first character from a non-empty string.
; Don’t worry about empty strings.

; 1) We use Strings to represent text, and 1String to represent a character
; 2)
;    - signature: String -> 1String
;    - statement of purpose: Computes the first character from a string
;    - header: (define string-first a-string)  "a")
; 3) Functional examples
;    - given : test, expect: t
;    - given : Pizza, expect: P
;    - given : 8675309, expect: 8
; 4) Take inventory: data is given through parameters
; 5) Code 
     (define (string-first str)(string-ith str 0))
; 6) Test
      (string-first "test")
      (string-first "Pizza")
      (string-first "8675309")