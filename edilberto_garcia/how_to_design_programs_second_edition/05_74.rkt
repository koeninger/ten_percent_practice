;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_74) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 74. Copy all relevant constant and function definitions to DrRacket’s definitions area.
;    Add the tests and make sure they pass. Then run the program and use the mouse to place the red dot.


(require 2htdp/image)
(require 2htdp/universe)

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
 
; A Posn represents the state of the world.



; Posn -> Image
; adds a red spot to MTS at p
(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))
(define (scene+dot p) (place-image DOT (posn-x p) (posn-y p) MTS))


; Posn -> Posn
; increases the x-coordinate of p by 3
(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))
(define (x+ p) (make-posn (+ (posn-x p) 3) (posn-y p)))

; MouseEvent -> Posn
(check-expect (reset-dot (make-posn 10 10) 100 10 "button-up") (make-posn 10 10))
(check-expect (reset-dot (make-posn 10 10) 100 10 "button-down") (make-posn 100 10))
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


