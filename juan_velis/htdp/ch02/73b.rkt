;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 73b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

; Posn -> Image
; adds a red spot to MTS at p
(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))

; Posn Number Number MouseEvt -> Posn 
; for mouse clicks, (make-posn x y); otherwise p
(check-expect
  (reset-dot (make-posn 10 20) 29 31 "button-down")
  (make-posn 29 31))
(check-expect
  (reset-dot (make-posn 10 20) 29 31 "button-up")
(make-posn 10 20))

(define (reset-dot p x y me)
  (cond
    [(mouse=? "button-down" me) (make-posn x y)]
[else p]))

; Posn -> Posn
; increases the x-coordinate of p by 3
(define (x+ p)
  (cond
    [(>= (posn-x p) 100) (make-posn 0 (posn-y p))]
    [else (posn-up-x (+ (posn-x p) 1) p)])
)
  
; Posn -> Posn
; increases the x-coordinate of px
(define (posn-up-x px py)
  (make-posn px (ypos (posn-y py)))
)

(define (ypos x)
  (+ x 0)
  ;(+ 50 (* 20 (deg2rad (* 360 x)) ))
)

;(define (deg2rad d)
  ;(sin (* d (/ pi 180)))
;)

; A Posn represents the state of the world. 
; Posn -> Posn 
(define (main p0)
  (big-bang p0
    [on-tick x+ 0.05]
    [on-mouse reset-dot]
    [to-draw scene+dot]))

(main (make-posn 0 50))

(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))