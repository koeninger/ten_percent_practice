;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex079) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A Color is one of:
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"
"white"
"blue"
"black"

; H is a Number between 0 and 100.
; interpretation represents a happiness value
0
50
100

(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)
(make-person "Joel" "Jimenez" #true)

(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)
; INTERPRENTATION (make-dog [(make-person fstname lstname male?) name age happiness] means a dog of
;   owner (make-person String String Boolean)
;   name String
;   age Number gte 0
;   happiness Number between 0 and 100
; dx pixels [per tick] along the horizontal and
; dy pixels [per tick] along the vertical direction
(make-dog (make-person "Charlie" "Brown" #true) "Snoopy" 68 100)
(make-dog (make-person "Shaggy" "Rogers" #true) "Scooby-Doo" 49 50)
(make-dog (make-person "Muriel" "Bagge" #false) "Courage" 18 0)

; A Weapon is one of:
; — #false
; — Posn
; interpretation #false means the missile hasn't
; been fired yet; a Posn means it is in flight
#false
(make-posn -1 1)
(make-posn 0 0)
(make-posn 1 -1)
