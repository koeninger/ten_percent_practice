;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |79|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Color is one of:
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"
(make-color "white")
(make-color "black")
(make-color "orange")
(make-color "green")

; H is a Number between 0 and 100.
; interpretation represents a happiness value
(make-h 0)
(make-h 100)
(make-h 45)

(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)
(make-person "Bob" "Smith" #true)
(make-person "Mary" "Smith" #true)

(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)
(make-dog (make-person "Bob" "Smith" #true) "Billy" 12 (make-H 65))
(make-dog (make-person "Mary" "Smith" #false) "Poochie" 5 (make-H 98))

; probably don't want a field name looking like a name of a struct/predicate
; to avoid confusion where it may be some other type requested

; A Weapon is one of:
; — #false
; — Posn
; interpretation #false means the missile hasn't
; been fired yet; a Posn means it is in flight
(make-weapon #false)
(make-weapon (make-posn 34 60))