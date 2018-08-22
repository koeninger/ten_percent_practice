;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |12|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; volume of equilateral cube
(define (cvolume x) (expt x 3))
(cvolume 3)

; surface of equilateral cube
(define (csurface x) (* 6 (* x x)))
(csurface 3)