;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex44) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; An AnimationState is a Number.
; interpretation the number of clock ticks 
; since the animation started

(define WIDTH-OF-WORLD 400)
(define HEIGHT-OF-WORLD 40)
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle WHEEL-DISTANCE WHEEL-RADIUS
                         "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))
(define BODY-LENGTH (+ WHEEL-DISTANCE (* 4 WHEEL-RADIUS)))
(define BODY-HEIGHT (* WHEEL-RADIUS 2))
(define BODY
  (above
    (rectangle (/ BODY-LENGTH 2) (/ BODY-HEIGHT 2)
               "solid" "red")
    (rectangle BODY-LENGTH BODY-HEIGHT "solid" "red")))

;; a car!
(define CAR (overlay/align/offset
             "middle" "bottom"
             BOTH-WHEELS
             0 (- 0 WHEEL-RADIUS)
             BODY))

(define Y-CAR (- HEIGHT-OF-WORLD (/ (image-height CAR) 2)))
(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define BACKGROUND (place-image
                    TREE
                    200 (- HEIGHT-OF-WORLD (/ (image-height TREE) 2))
                    (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD)))

(define (tock ws)
  (+ ws 1))
(check-expect (tock 20) 21)
(check-expect (tock 78) 79)

(define (render ws)
  (place-image/align CAR ws Y-CAR "right" "center" BACKGROUND))

(check-expect (render 50) (place-image/align CAR 50 Y-CAR "right" "center" BACKGROUND))
(check-expect (render 200) (place-image/align CAR 200 Y-CAR "right" "center" BACKGROUND))
(check-expect (render 450) (place-image/align CAR 450 Y-CAR "right" "center" BACKGROUND))

; Limit -> Boolean
; Returns true if x is greater than the width of the world+car
(define (limit x)
  (>= x (+ WIDTH-OF-WORLD (image-width CAR)))
)
(check-expect (limit 450) #true)

; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down" 
(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else x-position-of-car]))

; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
     [on-mouse hyper]
     [stop-when limit]
     ))