#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)
(require test-engine/racket-tests)

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

; Posn -> Posn
; increases the x-coordinate of p by 3

(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))

(define (x+ p)
  (make-posn (+ (posn-x p) 3) (posn-y p)))

; Posn -> Image
; adds a red spot to MTS at p

(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))

(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))

; Posn Number Number MouseEvt -> Posn
; for mouse clicks, (make-posn x y); otherwise p

(define (reset-dot p x y me)
  (cond
    [(mouse=? me "button-down") (make-posn x y)]
    [else p]))
 
; Posn -> Posn

(define (main p0)
  (big-bang p0
    [on-tick x+]
    [on-mouse reset-dot]
    [to-draw scene+dot]))

(test)
(main (make-posn 0 0))