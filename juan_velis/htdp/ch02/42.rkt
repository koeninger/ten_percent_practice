;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |42|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH-OF-WORLD 200)
(define Y-CAR 40)
 
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
  (overlay/xy TREE
   -120 35
  (rectangle WIDTH-OF-WORLD (* 4 WHEEL-RADIUS) "solid" "gray")
  )
)

(check-expect (tock 20) 23)
(check-expect (limit 250) #true)



; WorldState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render ws)
  (place-image CAR ws Y-CAR BACKGROUND)
)
 
; WorldState -> WorldState
; adds 3 to x to move the car right
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock x)
  (+ x 3)
)

; WorldState -> Boolean
; Returns true if x is greater than the width of the background considering car width
(define (limit x)
  (>= x (+ WIDTH-OF-WORLD (image-width CAR)))
)

; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
     [stop-when limit]
  )
)

(main 0)