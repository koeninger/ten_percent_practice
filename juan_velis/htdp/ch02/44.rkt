;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |44|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH-OF-WORLD 200)
(define Y-CAR 10)
 
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle WHEEL-RADIUS (* 2 WHEEL-RADIUS) "solid" "transparent"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))

(define CAR
  (overlay/xy
     BOTH-WHEELS
     (* WHEEL-RADIUS -0.5) (* WHEEL-RADIUS -2)
     (above
      (rectangle 15 (* WHEEL-RADIUS 1) "solid" "red")
      (rectangle 30 (* WHEEL-RADIUS 2) "solid" "red"))
  )
)

(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define BACKGROUND
  ;(overlay/xy TREE
  ; -120 35
  (rectangle WIDTH-OF-WORLD (* 4 WHEEL-RADIUS) "solid" "gray")
  ;)
)

(check-expect (tock 20) 23)
(check-expect (limit 250) #true)

; AnimationState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render as)
  (place-image CAR as (ypos as) BACKGROUND)
)
 
; AnimationState -> AnimationState
; adds 3 to x to move the car right
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock x)
  (+ x 3)
)

; AnimationState -> Boolean
; Returns true if x is greater than the width of the background considering car width
(define (limit x)
  (>= x (+ WIDTH-OF-WORLD (image-width CAR)))
)

; AnimationState -> Number
(define (ypos as)
 (+ 0 (* 20 (deg2rad as)))
)

(define (deg2rad d)
  (sin (* d (/ pi 180)))
)

; WorldState Number Number String -> WorldState
; places the car at x-mouse
(check-expect (hyper 21 10 20 "enter") 21)
(check-expect (hyper 42 10 20 "button-down") 10)
(check-expect (hyper 42 10 20 "move") 42)
(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else x-position-of-car]))

; AnimationState -> AnimationState
; launches the program from some initial state 
(define (main as)
   (big-bang as
     [on-tick tock]
     [to-draw render]
     [on-mouse hyper]
     [stop-when limit]
  )
)

(main 1)
