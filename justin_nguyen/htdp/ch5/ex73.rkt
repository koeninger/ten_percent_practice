;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex73) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Posn Number -> Posn
; replace x-coord of p with n
(check-expect (posn-up-x (make-posn 10 1) 5) (make-posn 5 1))
(check-expect (posn-up-x (make-posn 2 4) 0) (make-posn 0 4))
(define (posn-up-x p n) (make-posn n (posn-y p)))
