;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |59|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(define BACKGROUND (rectangle 90 30 "solid" "black"))
(define SPACER (rectangle 6 30 "solid" "black"))

; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next "red") "green")
(check-expect (tl-next "yellow") "red")
(check-expect (tl-next "green") "yellow")
(define (tl-next cs)
  (cond
    [(string=? "red" cs) "green"]
    [(string=? "green" cs) "yellow"]
    [(string=? "yellow" cs) "red"]))
 
; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render "red")
  (overlay/align "center" "center" (light "red") (empty-scene 90 30)))
(define (tl-render current-state)
  (overlay/align "center" "center"
   (light current-state)              
   (empty-scene 90 30)
  )
)

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))


; String -> Image
; Draws 3 color traffic light
(define (light color)
  (overlay/align "center" "center"                 
   (beside (circle 10 (if (string=? color "yellow") "solid" "outline") "yellow") SPACER
           (circle 10 (if (string=? color "green") "solid" "outline") "green") SPACER
           (circle 10 (if (string=? color "red") "solid" "outline") "red"))
   BACKGROUND
   )
)

(traffic-light-simulation "red")