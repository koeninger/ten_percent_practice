;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_79) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 79. Create examples for the following data definitions:

; A Color is one of:
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"

(define-struct Color [color])



; H is a Number between 0 and 100.
; interpretation represents a happiness value


(define-struct person [fstname lstname male?])
; A Person is a structure:
;    (make-person String String Boolean)



; Is it a good idea to use a field name that looks like the name of a predicate?



; (define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)


; Add an interpretation to this data definition, too.

; A Weapon is one of:
; — #false
; — Posn
; interpretation #false means the missile hasn't
; been fired yet; a Posn means it is in flight 

; The last definition is an unusual itemization, combining built-in data with a structure type. The next chapter deals with such definitions in depth.