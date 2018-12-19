;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex105) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point


; distance 1 below top
(make-coord -1)
; distance 2 below top
(make-coord -2)
; distance 1 from left
(make-coord 1)
; distance 2 from left
(make-coord 2)
; a point 2 left from y-axis and 3 up from the x-axs
(make-coord (make-posn 2 3))
; a point 1 from y-axis and 1 down from the x-axis
(make-coord (make-posn 1 -1))
(define struct coord [n])

; template
(define (coordtemp n)
  (cond
    [(number? n) ...]
    [(posn? n) ...]))