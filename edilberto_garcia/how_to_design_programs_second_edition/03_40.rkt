;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03_40) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


(require 2htdp/image)
(require 2htdp/universe)


(define WIDTH-OF-WORLD 200) 
(define WHEEL-RADIUS 5)
;(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE  (rectangle (* WHEEL-RADIUS 6) (* WHEEL-RADIUS 3) "solid" "red"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))

(define BACKGROUND
  (rectangle (* WHEEL-RADIUS 70) (* WHEEL-RADIUS 10)  "solid" "gray")
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

;Exercise 40. Formulate the examples as BSL tests,
;  that is, using the check-expect form. Introduce a mistake. Re-run the tests.

(check-expect (tock 20) 23)
(check-expect (tock 78) 81)