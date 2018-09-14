#! /usr/local/bin/racket
#lang racket
(require 2htdp/image)

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

; Creates a red chassis for a CAR based on WHEEL-RADIUS as single point of control for the size
(define CHASSIS-BOTTOM
  (rectangle (* WHEEL-RADIUS 8) (* WHEEL-RADIUS 2) "solid" "red"))
(define CHASSIS-TOP
  (rectangle (* WHEEL-RADIUS 4) WHEEL-RADIUS "solid" "red"))
(define CHASSIS
  (underlay/offset CHASSIS-TOP 0 (* WHEEL-RADIUS 1.5) CHASSIS-BOTTOM))

; Creates a car image based on WHEEL-RADIUS as single point of control for the size
(define CAR
  (underlay/offset CHASSIS 0 (* WHEEL-RADIUS 1.5) BOTH-WHEELS))
CAR

; WorldState -> WorldState
; moves the car by 3 pixels for every clock tick
; examples:
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock ws)
  (+ ws 3))
(tock 20)
(tock 78)
