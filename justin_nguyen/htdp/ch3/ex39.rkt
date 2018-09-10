;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex39) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

; WorldState -> Image
; big-bang creates image of current state by evaluating (render cw)
(define (render ws) ...)

; WorldState -> WorldState
; for each tick, big-bang gets next state of world from (clock-tick-handler cw)
(define (clock-tick-handler cw) ...)

; WorldState String -> WorldState
; for each keystroke, big-bang gets next state of world from (keystroke-handler cw ke)
(define (keystroke-handler cw ke) ...)

; WorldState Number Number String -> WorldState
; for reach mouse movement, big-bang obtains next state of world from (mouse-event-handler cw x y me)
; wgere x and y are coords of the event and me is the description
(define (mouse-event handler cw x y me) ...)

; WorldState -> Boolean
; after each event, big-bang evaluates (end? cw)
(define (end? cw) ...)

(define WIDTH-OF-WORLD 200)

(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle 10 WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
(define CAR-BODY
  (underlay/offset
    (rectangle (* WHEEL-RADIUS 8) (* WHEEL-RADIUS 2) "solid" "red")
    0 (- 0 WHEEL-RADIUS)
    (rectangle (* WHEEL-RADIUS 4) (* WHEEL-RADIUS 4) "solid" "red")))
  
(define CAR
  (underlay/offset
   CAR-BODY
   0 (* WHEEL-RADIUS 2)
   BOTH-WHEELS))

(define (tock ws)
  (+ ws 3))

;(define (main ws)
;  (big-bang ws
;    [on-tick tock]
;    [to-draw render]))