;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex44) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

 
(define WHEEL-RADIUS 5)


(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle (* 2 WHEEL-RADIUS) WHEEL-RADIUS "solid" "white"))

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


(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define BACKGROUND
  (place-image/align tree
      (* .5 WIDTH-OF-WORLD) (*  WIDTH-OF-WORLD .2) "left" "bottom"
   (empty-scene WIDTH-OF-WORLD (*  WIDTH-OF-WORLD .2)))
  )


(define Y-CAR (- (image-height BACKGROUND) (image-height CAR)))

(define (sinY val)
 (+ (* 18 (sin (* .25 val) ))  Y-CAR)
  )

; WorldState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render x)
  (place-image/align CAR x (sinY x) "right" "top" BACKGROUND))



; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
; examples: 
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock ws)
  (+ ws 3))


; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down"
; given: 21 10 20 "enter"
; wanted: 21
; given: 42 10 20 "button-down"
; wanted: 10
; given: 42 10 20 "move"
; wanted: 42
(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else x-position-of-car]))

(check-expect (hyper 21 10 20 "enter") 21)
(check-expect (hyper 42 10 20 "button-down") 10)
(check-expect (hyper 42 10 20 "move") 42)


;number->boolean
; returns false if val is greater then the background size + car
;
(define (end val)
  (> val (+ (image-width CAR) (image-width BACKGROUND)))
  )


;a sin (bx+c)

; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
     [on-mouse hyper]
     [stop-when end]))


    (main 1)
