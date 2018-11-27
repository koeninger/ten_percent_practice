;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |105|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(define BACKGROUND (empty-scene 500 500))
(define POINT (circle 5 "solid" "red"))

; A Coordinate is one of:
; – a NegativeNumber
; interpretation on the y axis, distance from top
; – a PositiveNumber
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

(define NEG-NUM1 -10)
(define NEG-NUM2 -100)
(define POS-NUM1 10)
(define POS-NUM2 100)
(define POSN1 (make-posn 10 10))
(define POSN2 (make-posn 100 100))

(place-image POINT 0 (* NEG-NUM1 -1) BACKGROUND)
(place-image POINT 0 (*  NEG-NUM2 -1) BACKGROUND)
(place-image POINT POS-NUM1 0 BACKGROUND)
(place-image POINT POS-NUM2 0 BACKGROUND)
(place-image POINT (posn-x POSN1) (posn-y POSN1) BACKGROUND)
(place-image POINT (posn-x POSN2) (posn-y POSN2) BACKGROUND)
