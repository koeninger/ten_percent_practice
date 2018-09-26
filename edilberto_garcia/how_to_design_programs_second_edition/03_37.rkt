;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03_37) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 37. Design the function string-rest,
;    which produces a string like the given one with the first character removed. 

; 1) We use String to represent strings
;
; 2)
;    - signature: String -> String
;    - statement of purpose: Computes the strings with the first character removed
;    - header: (define string-rest a-string)  a-modified-string)
;
; 3) Functional examples
;    - given "hello": , expect: "ello"
;    - given "sup': , expect: "up"
;    - given "8675309":, expect "675309"
;
; 4) Take inventory: data is given through parameters
;
; 5) Code
    (define (string-rest input)
        (substring input 1)
    )
;
; 6) Test

(string-rest "hello")
(string-rest "sup")
(string-rest "9675309")