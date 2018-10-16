;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03_44_fixed) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Sample Problem Design a program that moves a car across the world canvas,
;    from left to right, at the rate of three pixels per clock tick.
;    *If the mouse is clicked anywhere on the canvas,
;    the car is placed at the x-coordinate of that click.*




(require 2htdp/image)
(require 2htdp/universe)


(define WHEEL-RADIUS 5)
(define WIDTH-OF-THE-WORLD (* WHEEL-RADIUS 70))
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE  (rectangle (* WHEEL-RADIUS 6) (* WHEEL-RADIUS 3) "solid" "red"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))
(define tree (underlay/xy (circle 10 "solid" "green")
              9 15
              (rectangle 2 20 "solid" "brown")))
(define TREE_X (/ WIDTH-OF-THE-WORLD 1.5))
(define TREE_Y (/ WIDTH-OF-THE-WORLD 8))
(define BACKGROUND
  (place-image tree TREE_X TREE_Y
  (rectangle WIDTH-OF-THE-WORLD (* WHEEL-RADIUS 10)  "solid" "gray")
  )
)
(define CAR_BASE (rectangle (* WHEEL-RADIUS 10) (* WHEEL-RADIUS 3) "solid" "gold"))
(define CAR_WINDOW
  (rectangle WHEEL-RADIUS WHEEL-RADIUS "solid" "silver")
)
(define CAR
  (place-image WHEEL (* WHEEL-RADIUS 1.8) (* WHEEL-RADIUS 2.5)
  (place-image WHEEL  (* WHEEL-RADIUS 7.8) (* WHEEL-RADIUS 2.5)
  (place-image CAR_WINDOW (* WHEEL-RADIUS 6.2) (* WHEEL-RADIUS .8) CAR_BASE)))
)
(define CAR_Y (* WHEEL-RADIUS 6))

; AnimationState -> Boolean
; stops program when the car has passed the right edge
(define (stop_check x)
 (>= x (+ WIDTH-OF-THE-WORLD (image-width CAR)) ) 
)

; AnimationState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render x) (place-image CAR x CAR_Y BACKGROUND ))


; clock-tick-handler
; AnimationState -> AnimationState
; Moves the car in a sine wave 
(define (tock x)(+ 3 x))



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
  


(define (main ws)
   (big-bang ws
     [on-tick tock]
     [on-mouse hyper]
     [to-draw render]
     [stop-when stop_check]))


(check-expect (hyper 21 10 20 "enter") 21)
(check-expect (hyper 42 10 20 "button-down") 10)
(check-expect (hyper 42 10 20 "move") 42)


