;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex041) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; An AnimationState is a Number.
; interpretation the number of clock ticks
; since the animation started

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
(define OFFSET (* WHEEL-RADIUS 4))

; Creates a red CAR-BODY for a CAR based on WHEEL-RADIUS as single point of control for the size
(define CAR-BODY-BOTTOM
  (rectangle (* OFFSET 2) (* WHEEL-RADIUS 2) "solid" "red"))
(define CAR-BODY-TOP
  (rectangle OFFSET WHEEL-RADIUS "solid" "red"))
(define CAR-BODY
  (underlay/offset CAR-BODY-TOP 0 (* WHEEL-RADIUS 1.5) CAR-BODY-BOTTOM))

; Creates a car image based on WHEEL-RADIUS as single point of control for the size
(define CAR
  (underlay/offset CAR-BODY 0 (* WHEEL-RADIUS 1.5) BOTH-WHEELS))

(define TREE
  (underlay/offset (circle (* WHEEL-RADIUS 2) "solid" "green")
    0 OFFSET
    (rectangle (/ WHEEL-RADIUS 2) OFFSET "solid" "brown")))

(define Y-CAR OFFSET)
(define MAX-X
  (* WHEEL-RADIUS 60))
(define MAX-TICKS
  (/ MAX-X 3))
(define BACKGROUND
  (empty-scene MAX-X (* WHEEL-RADIUS 6)))
(define BACKGROUND-TREE
  (place-image TREE (/ MAX-X 2) Y-CAR BACKGROUND))

; AnimationState -> AnimationState
; moves the car by 3 pixels for every clock tick
; examples:
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock as)
  (+ as 1))

; AnimationState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state
(define (render as)
  (place-image CAR (render-x as) (render-y as) BACKGROUND-TREE))

(define (render-x as)
  (- (* as 3) OFFSET))
(define (render-y as)
  (* (sin as) OFFSET))

; AnimationState -> Boolean
; after each event, big-bang evaluates (end? cw)
(define (end? cw)
  (> cw MAX-TICKS))

; AnimationState -> AnimationState
; launches the program from some initial state
(define (main as)
   (big-bang as
     [on-tick tock]
     [to-draw render]
     [stop-when end?]))

(main 10)

(check-expect (tock 20) 21)
(check-expect (tock 78) 79)
(check-expect (end? (* WHEEL-RADIUS 61)) #true)
(check-expect (end? (* WHEEL-RADIUS 59)) #false)
