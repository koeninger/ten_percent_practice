;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |60|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(define BACKGROUND (rectangle 90 30 "solid" "black"))
(define SPACER (rectangle 6 30 "solid" "black"))

; N-TrafficLight -> N-TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next-numeric 0) 1)
(check-expect (tl-next-numeric 1) 2)
(check-expect (tl-next-numeric 2) 0)
(define (tl-next-numeric cs) (modulo (+ cs 1) 3))

; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render 0)
  (overlay/align "center" "center" (light 0) (empty-scene 90 30)))
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
    [on-tick tl-next-numeric 1]))


; Number -> Image
; Draws 3 color traffic light
(define (light color)
  (overlay/align "center" "center"                 
   (beside (circle 10 (if (= 0 color) "solid" "outline") "red") SPACER
           (circle 10 (if (= 2 color) "solid" "outline") "yellow") SPACER
           (circle 10 (if (= 1 color) "solid" "outline") "green"))
   BACKGROUND
   )
)

(traffic-light-simulation 0)