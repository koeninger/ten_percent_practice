;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |39|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH-OF-WORLD 200)
(define Y-CAR 5)
 
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle WHEEL-RADIUS (* 2 WHEEL-RADIUS) "solid" "white"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))

(define CAR
 BOTH-WHEELS 
)

(define BACKGROUND
  (rectangle WIDTH-OF-WORLD (* 4 WHEEL-RADIUS) "solid" "white"))

; WorldState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render x)
  BACKGROUND)
 
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

(main 13)