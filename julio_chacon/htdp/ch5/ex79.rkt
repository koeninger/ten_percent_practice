;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex79) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Color is one of: 
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"
(define-struct Color  [colorName])
;   (make-Color String)
; interpretation colorName is a string defining color
(make-Color "red")

; H is a Number between 0 and 100.
; interpretation represents a happiness value
(define-struct Happines [level])
;(make-Happines Number)
(make-Happines 76)


(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)
(make-person "John" "Smith" #true)


(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)
(make-dog (make-person "John" "Smith" #true) "fido" 3 (make-Happines 80))