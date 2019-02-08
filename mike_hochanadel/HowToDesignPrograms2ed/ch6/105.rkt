;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |105|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

(define negativeNumberEx1 -10)
(define negativeNumberEx2 -100)
(define positiveNumberEx1 10)
(define positiveNumberEx2 100)
(define posnEx1 (make-posn 10 10))
(define posnEx2 (make-posn 100 100))

; since it is ONE OF, it implies as with
; other examples in the book that it can be
; only a negative number, a positive number,
; or a Posn.  So if it is negative then
; it is somewhere on x with a negative number
; denoting distance y from top.  if it is a
; positive number then it is somewhere on y
; with a x distance from the left.  if it is
; a Posn then it is a cartesian coordinate

(define exSc (empty-scene 120 120))