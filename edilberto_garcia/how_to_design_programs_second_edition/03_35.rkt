;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03_35) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 35. Design the function string-last,
; which extracts the last character from a non-empty string.

; 1) We use Strings to represent text, and 1String to represent a character
; 2)
;    - signature: String -> 1String
;    - statement of purpose: Computes the last character from a string
;    - header: (define string-last a-string)  "z")
; 3) Functional examples
;    - given : test, expect: t
;    - given : Pizza, expect: a
;    - given : 8675309, expect: 9
; 4) Take inventory: data is given through parameters
; 5) Code 
     (define
       (string-last str)
       (substring str (- (string-length str) 1) (string-length str))
      )
; 6) Test
      (string-last "test")
      (string-last "Pizza")
      (string-last "8675309")