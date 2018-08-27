;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ch3-0) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; definitions

; functions

; String -> Character
; extracts the first character of a string
; given: Hello World, expect: H
(define (string-first str)
  (substring str 0 1))

; String -> Character
; extracts the last character from a string
; given: Hello World!, expects: !
(define (string-last str)
  (substring str (- (string-length str) 1)))

; Image -> Number
; counts the number of pixels in an image
; given: a 10x10 square, expects: 100
(define (image-area img)
   (* (image-width img) (image-height img)))

; String -> String
; returns the string with the first character removed
; given:  Hello World!, expects: ello World!
(define (string-rest str)
  (substring str 1))

; String -> String
; returns the string with the last character removed
; give: Hello World!, expects: Hello World
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))

; Number -> Number
; converts Fahrenheit temperature to Celsius
; given 32, expect 0
; given 212, expect 100
; given -40, expect -40
(define (f2c f)
  (* 5/9 (- f 32)))

; scratch
(string-first "Hello World!")
(string-last "Hello World!")
(image-area (square 10 "solid" "red"))
(string-rest "Hello World!")
(string-remove-last "Hello World!")
(check-expect (f2c -40) -40)
(check-expect (f2c 32) 0)
(check-expect (f2c 212) 100)
