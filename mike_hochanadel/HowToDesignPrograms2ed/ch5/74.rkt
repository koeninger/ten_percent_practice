;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |74|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
(define MOMENTUM 3)
 
; A Posn represents the state of the world.
 
; Posn -> Image
; adds a red spot to MTS at p
(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))
(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))

; Posn -> Posn
; Updates the X coordinate of a given Posn with the Number n
(check-expect (posn-up-x (make-posn 10 0) 3) (make-posn 3 0))
(check-expect (posn-up-x (make-posn 10 0) 0) (make-posn 0 0))
(check-expect (posn-up-x (make-posn 10 0) 10) (make-posn 10 0))
(check-expect (posn-up-x (make-posn 10 0) -1) (make-posn -1 0))
(define (posn-up-x p n)
  (make-posn n (posn-y p)))

; Posn -> Posn
; increases the x-coordinate of p by the MOMENTUM
(check-expect (x+ (make-posn 10 0)) (make-posn (+ 10 MOMENTUM) 0))
(define (x+ p)
  (posn-up-x p (+ (posn-x p) MOMENTUM)))

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
    [(mouse=? me "button-down") (make-posn x y)]
    [else p]))

; Posn -> Posn 
(define (main p0)
  (big-bang p0
    [on-tick x+]
    [on-mouse reset-dot]
    [to-draw scene+dot]))