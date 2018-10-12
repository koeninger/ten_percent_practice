;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex39) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

 
(define WHEEL-RADIUS 10)
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define SPACE
  (rectangle WHEEL-RADIUS WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
(define CAR-BODY
  (overlay/offset (rectangle (* WHEEL-RADIUS 4) (* WHEEL-RADIUS 2) "solid" "red")
                  0 (* WHEEL-RADIUS 1.5)
                  (rectangle (* WHEEL-RADIUS 8) (* WHEEL-RADIUS 2) "solid" "red"))
)

(define CAR
 (overlay/xy
      BOTH-WHEELS
       (- (* .5 (image-width BOTH-WHEELS) ) (* .5 (image-width  CAR-BODY)) ) (- (* .5 (image-height BOTH-WHEELS)) (image-height CAR-BODY) )
       CAR-BODY))



(define WIDTH-OF-WORLD (* WHEEL-RADIUS 50))

(define BACKGROUND (empty-scene WIDTH-OF-WORLD (*  WIDTH-OF-WORLD .2)))
(define Y-CAR (- (image-height BACKGROUND) (* .5 (image-height CAR)) ))

; WorldState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render x)
  (place-image CAR x Y-CAR BACKGROUND))



; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
; examples: 
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock ws)
  (+ ws 3))


; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]))