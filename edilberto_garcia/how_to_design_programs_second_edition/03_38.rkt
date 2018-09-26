;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03_38) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 38. Design the function string-remove-last,
;    which produces a string like the given one with the last character removed. 

; 1) We use String to represent strings
;
; 2)
;    - signature: String -> String
;    - statement of purpose: Computes the strings with the last character removed
;    - header: (define string-rest a-string)  a-modified-string)
;
; 3) Functional examples
;    - given "hello": , expect: "hell"
;    - given "sup': , expect: "su"
;    - given "8675309":, expect "867530"
;
; 4) Take inventory: data is given through parameters

(define (string-remove-last-template input) (    ... input ... ))

; 5) Code
    (define (string-remove-last input)
        (substring input 0 (- (string-length input) 1))
    )
;
; 6) Test

(string-remove-last "hello")
(string-remove-last "sup")
(string-remove-last "8675309")