;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |79|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Color is one of: 
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"

(define Color "Black")

(define (fn-for-color c)
  (cond [(and (string? c) (or (eq? "white" c) (eq? "yellow" c))) ...]
        [else ...]))

; H is a Number between 0 and 100.
; interpretation represents a happiness value
(define-struct happiness [level])
(define depressed (make-happiness 20))
(define joyful (make-happiness 90))


(define happy 75)
(define sad 25)
(define (fn-for-happiness H)
  (cond [(<= 0 H sad) ... ]
        [(and (> sad H) (< H happy )) ... ]
        [(>= H happy) ... ]
))

(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)
(define director (make-person "Dorian" "Lest" #true))

(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)
(define shelty(make-dog "Dorian" "Andy" 5 (make-happiness 80)))

; A Weapon is one of: 
; — #false
; — Posn
; interpretation #false means the missile hasn't 
; been fired yet; a Posn means it is in flight

(define-struct Weapon [fired? posn])
(define tomahawk (make-Weapon #false (make-posn 0 0)))
(define exocet (make-Weapon #true (make-posn 100 200)))