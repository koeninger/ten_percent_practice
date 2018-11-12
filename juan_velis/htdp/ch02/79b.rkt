;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 79b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct r3 [x y z])
; An R3 is a structure:
;   (make-r3 Number Number Number)
 
(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))

; R3 -> Number 
; determines the distance of p to the origin
; r3-x gets x from an r3 structure point in space
; r3-y gets y from an r3 structure point in space
; r3-z gets z from an r3 structure point in space
(define (r3-distance-to-0 p) 
                          (sqrt (+ (r3-x p)
                                   (r3-y p)
                                   (r3-z p)))
)

(r3-distance-to-0 ex1)
