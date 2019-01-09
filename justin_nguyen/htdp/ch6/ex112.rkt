;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex112) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; A MissileOrNot is one of: 
; – #false
; – Posn
; interpretation#false means the missile is in the tank;
; Posn says the missile is at that location
(check-expect (missle-or-not? #false) #true)
(check-expect (missle-or-not? #true) #false)
(check-expect (missle-or-not? (make-posn 1 2)) #true)
(define (missle-or-not? v)
  (cond
    [(or (false? v) (posn? v)) #true]
    [else #false]))