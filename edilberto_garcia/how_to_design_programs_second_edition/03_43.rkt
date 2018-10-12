;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03_43) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 43. Let’s work through the same problem statement
;    with a time-based data definition:


; An AnimationState is a Number.
; interpretation the number of clock ticks 
; since the animation started




; Design the functions tock and render.
; Then develop a big-bang expression so that once again you get an
; animation of a car traveling from left to right across the world’s canvas.



; AnimationState -> AnimationState
; moves the car by 3 pixels for every clock tick
; examples: 
;   given: 20, expect 23
;   given: 78, expect 81
;(define (clock-tick-handler cw) ...)

; AnimationState -> Image
; places the car into the BACKGROUND scene,
; according to the given animation state 
;(define (render ws) ...)


;How do you think this program relates to animate from Prologue: How to Program?

; These are very similar,
;    it seems this car program using big-bang is a more crude animate function



; Use the data definition to design a program that moves
;    the car according to a sine wave. (Don’t try to drive like that.)


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