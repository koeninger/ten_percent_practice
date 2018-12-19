;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_73) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 73. Design the function posn-up-x, which consumes a Posn p and a Number n.
;    It produces a Posn like p with n in the x field.



(define (posn-up-x p n)
    (make-posn n (posn-y p))
)

