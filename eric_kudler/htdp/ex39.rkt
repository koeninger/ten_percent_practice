;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex39) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH-OF-WORLD 200)
 
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define BACKGROUND (empty-scene 250 50))
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define BODY
  (rectangle (* 8 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red"))
(define HEAD
  (rectangle (* 4 WHEEL-RADIUS) (* 1 WHEEL-RADIUS) "solid" "red"))
(define SPACE
  (rectangle (* 2 WHEEL-RADIUS) WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
(define CAR
  (above HEAD BODY BOTH-WHEELS))

; WorldState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render x)
  (overlay/offset CAR x 0 BACKGROUND ))

; WorldState -> WorldState
; adds 3 to x to move the car right 
(define (tock x)
  x)

; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]))

(main 100)