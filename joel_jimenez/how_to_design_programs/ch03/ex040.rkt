#! /usr/local/bin/racket
#lang racket
(require 2htdp/image)
(require test-engine/racket-tests)

; The length pixels for a WHEEL
; Used as single point of control for the size of the car
(define WHEEL-RADIUS 5)

; Creates a wheel with a radius of WHEEL-RADIUS
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
; Creates a horizontal space the size of a WHEEL
(define SPACE
  (rectangle (* WHEEL-RADIUS 2) 0 "solid" "white"))
; Creates a set of WHEELS separated by a SPACE
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))

; Creates a red CAR-BODY for a CAR based on WHEEL-RADIUS as single point of control for the size
(define CAR-BODY-BOTTOM
  (rectangle (* WHEEL-RADIUS 8) (* WHEEL-RADIUS 2) "solid" "red"))
(define CAR-BODY-TOP
  (rectangle (* WHEEL-RADIUS 4) WHEEL-RADIUS "solid" "red"))
(define CAR-BODY
  (underlay/offset CAR-BODY-TOP 0 (* WHEEL-RADIUS 1.5) CAR-BODY-BOTTOM))

; Creates a car image based on WHEEL-RADIUS as single point of control for the size
(define CAR
  (underlay/offset CAR-BODY 0 (* WHEEL-RADIUS 1.5) BOTH-WHEELS))

; WorldState -> WorldState
; moves the car by 3 pixels for every clock tick
; examples:
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock ws)
  (+ ws 3))
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)
(test)

(define BACKGROUND
  (empty-scene (* WHEEL-RADIUS 60) (* WHEEL-RADIUS 6)))
(define Y-CAR (* WHEEL-RADIUS 4))
(define X-OFFSET (* WHEEL-RADIUS 4))

; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state
(define (render ws)
  (place-image CAR (+ ws  X-OFFSET) Y-CAR BACKGROUND))
(render 50)
(render 100)
(render 150)
(render 200)
