;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03_41) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


(require 2htdp/image)
(require 2htdp/universe)



(define WHEEL-RADIUS 5)
(define WIDTH-OF-THE-WORLD (* WHEEL-RADIUS 70))
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE  (rectangle (* WHEEL-RADIUS 6) (* WHEEL-RADIUS 3) "solid" "red"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))

(define BACKGROUND
  (rectangle WIDTH-OF-THE-WORLD (* WHEEL-RADIUS 10)  "solid" "gray")
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

; render
; WorldState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render x) (place-image CAR x CAR_Y BACKGROUND ))



; clock-tick-handler
; WorldState -> WorldState
; adds 3 to x to move the car right 
(define (tock x)(+ 3 x))


; keystroke-handler
; mouse-event-handler
; end?

; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]))



; Exercise 41. Finish the sample problem and get the program to run.
; That is, assuming that you have solved exercise 39,
; define the constants BACKGROUND and Y-CAR.
; Then assemble all the function definitions, including their tests.
; When your program runs to your satisfaction, add a tree to the scenery. We used

(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))


; to create a tree-like shape.
; Also add a clause to the big-bang expression that stops the
; animation when the car has disappeared on the right side.
... 
