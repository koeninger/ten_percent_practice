;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |105|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

(define-struct coordinate [pos])

; this is a point on the y axis
(define coordy (make-coordinate 10))
(define coordy2 (make-coordinate 5))

; this is a point on the x axis
(define coordx (make-coordinate 20))
(define coordx2 (make-coordinate 25))

; this is a x,y point on the canvas
(define coord (make-coordinate (make-posn 20 10)))
(define coord2 (make-coordinate (make-posn 25 5)))