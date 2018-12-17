#lang racket

(require 2htdp/image)
(require 2htdp/universe)

(define MIN-HAPPINESS 0)
(define MAX-HAPPINESS 100)

(define FRAME-HEIGHT 10)
(define FRAME (rectangle MAX-HAPPINESS FRAME-HEIGHT "outline" "black"))

; WorldState -> WorldState
; with each clock tick, happiness decreases by -0.1;
; it never falls below 0, the minimum happiness score.

(define (tock happiness)
  (cond
    [(> happiness MAX-HAPPINESS) MAX-HAPPINESS]
    [(> happiness MIN-HAPPINESS) (- happiness .1)]
    [else MIN-HAPPINESS]))

; WorldState -> Image
; creates gauge according to happiness

(define (gauge happiness)
  (rectangle (* (image-width FRAME) (/ happiness MAX-HAPPINESS)) FRAME-HEIGHT "solid" "red"))
  
; WorldState -> Image
; places the FRAME onto the gauge
(define (render happiness)
   (overlay/align "left" "middle" FRAME (gauge happiness)))

; WorldState -> WorldState
; every time the down arrow key is pressed, happiness increases by 1/5;
; every time the up arrow is pressed, happiness jumps by 1/3.

(define (key-handler happiness key)
  (cond
    [(key=? key "up") (+ happiness 1/3)]
    [(key=? key "down") (+ happiness .2)]
    [else happiness]))

; WorldState -> WorldState
; launches the program from some initial state

(define (gauge-prog)
   (big-bang MAX-HAPPINESS
     [on-tick tock]
     [to-draw render]
     [on-key key-handler]))

(gauge-prog)