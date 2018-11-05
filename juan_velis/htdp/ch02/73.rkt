;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |73|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
(define (reset-dot p x y me) p)

; Posn -> Posn
; increases the x-coordinate of p by 3
(define (x+ p)
  (posn-up-x (+ (posn-x p) 3) p))
  
; Posn -> Posn
; increases the x-coordinate of px
(define (posn-up-x px py)
  (make-posn px (posn-y py))                                             
)

; A Posn represents the state of the world. 
; Posn -> Posn 
(define (main p0)
  (big-bang p0
    [on-tick x+ 0.5]
    [on-mouse reset-dot]
    [to-draw scene+dot]))

(main (make-posn 0 50))

(define (reset+dot p)
  (place-image DOT 50 50 MTS))

(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))