;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_66) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 66. Revisit the structure type definitions of exercise 65.
;    Make sensible guesses as to what kind of values go with which fields.
;    Then create at least one instance per structure type definition.


(define-struct movie [title producer year])
;title - string
;producer - string
;year - integer 

(define-struct person [name hair eyes phone])
;name - string
;hair - string
;eyes - string
;phone - string

(define-struct pet [name number])
;name - string
;number - int, or string if too long

(define-struct CD [artist title price])
; artist - string
; title - string
; price - int

(define-struct sweater [material size producer])
; material - string
; size - string
; producer - string

(make-movie "Catwoman" "Village Roadshow Pictures" 2004)
(make-person "Martin Shkreli" "black" "brown" "609-723-1100")
(make-pet "Bubastis" "12344-23423")
(make-CD "Various" "Star Wars Holiday Special Soundtrack" 1.99)
(make-sweater "Cotton/Polyester" "XL" "Dolce & Gabbana")