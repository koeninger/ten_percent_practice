;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03_42) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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



; WorldState -> Boolean
; stops program when the car has passed the right edge
(define (stop_check x)
 (>= x (+ WIDTH-OF-THE-WORLD (image-width CAR)) ) 
)

; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state 
(define (render ws) (place-image CAR ws CAR_Y BACKGROUND ))

; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
; examples: 
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock x)(+ 3 x))

; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
     [stop-when stop_check]))



;Exercise 42.
;Modify the interpretation of the sample data definition so that a state denotes
;the x-coordinate of the right-most edge of the car. 

