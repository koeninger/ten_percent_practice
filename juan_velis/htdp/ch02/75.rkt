;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |75|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct vel [deltax deltay])
(define-struct ufo [loc vel])
; A UFO is a structure:
;   (make-ufo Posn Vel)
; interpretation (make-ufo p v) is at location
; p moving at velocity v.


; UFO -> ???
(define (fun-for-ufo u)
  (... (posn-x (ufo-loc u)) ...
   ... (posn-y (ufo-loc u)) ...
   ... (vel-deltax (ufo-vel u)) ...
   ... (vel-deltay (ufo-vel u)) ...))

;; It is your task to develop ufo-move-1. The function computes the location
;; of a given UFO after one clock tick passes.

;; some UFO examples:
(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))

(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))

(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))

; UFO -> UFO
; determins where u move in one clock tick;
; leaves the velocity as is

(check-expect (ufo-move-1 u1) u3)
(check-expect (ufo-move-1 u2)
              (make-ufo (make-posn 17 77) v2))

;(define (ufo-move-1 u) u) ; stub

(define (ufo-move-1 u)
  (make-ufo (posn+ (ufo-loc u) (ufo-vel u))
            (ufo-vel u)))

;; If a function deals with nested structures, develop one function per
;; level of nesting.

; Posn Vel -> Posn
; adds v to p
(check-expect (posn+ p1 v1) p2)
(check-expect (posn+ p1 v2) (make-posn 17 77))

;(define (posn+ p v) p) ; stub

#;; template
(define (posn+ p v)
  (... (posn-x p) ... (posn-y p) ...
   ... (vel-deltax v) ... (vel-deltay v) ...))

(define (posn+ p v)
  (make-posn (+ (posn-x p) (vel-deltax v))
(+ (posn-y p) (vel-deltay v))))