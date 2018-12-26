#lang racket

(require 2htdp/image)
(require 2htdp/universe)

(define MIN-HAPPINESS 0)
(define MAX-HAPPINESS 100)

(define FRAME-WIDTH MAX-HAPPINESS)
(define FRAME-HEIGHT 10)
(define FRAME (rectangle FRAME-WIDTH FRAME-HEIGHT "outline" "black"))

; WorldState -> WorldState
; with each clock tick, happiness decreases by -0.1;
; it never falls below 0, the minimum happiness score.

(define (tock happiness)
  (min (max (- happiness .1)
            MIN-HAPPINESS)
       MAX-HAPPINESS))

; WorldState -> Image
; creates gauge according to happiness

(define (gauge happiness)
  (rectangle (* FRAME-WIDTH (/ happiness MAX-HAPPINESS)) FRAME-HEIGHT "solid" "red"))
  
; WorldState -> Image
; places the FRAME onto the gauge

(define (render happiness)
   (overlay/align "left" "middle" FRAME (gauge happiness)))

; WorldState -> WorldState
; every time the down arrow key is pressed, happiness increases by 1/5;
; every time the up arrow is pressed, happiness jumps by 1/3.

(define (key-handler happiness key)
  (+ happiness (cond
                 [(key=? key "up") 1/3]
                 [(key=? key "down") .2]
                 [else 0])))

; WorldState -> WorldState
; launches the program from some initial state

(define (gauge-prog)
   (big-bang MAX-HAPPINESS
     [on-tick tock]
     [to-draw render]
     [on-key key-handler]))

(gauge-prog)