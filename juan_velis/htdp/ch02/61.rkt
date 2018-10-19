;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |61|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(define BACKGROUND (rectangle 90 30 "solid" "black"))
(define SPACER (rectangle 6 30 "solid" "black"))
(define RED "red")
(define GREEN "green")
(define YELLOW "yellow")

; S-TrafficLight -> S-TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next RED) GREEN)
(check-expect (tl-next GREEN) YELLOW)
(check-expect (tl-next YELLOW) RED)
(define (tl-next cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))

; S-TrafficLight -> S-TrafficLight
; yields the next state, given current state cs
;
; Doesn't work with strings, while tl-next works with strings and numbers
;
(define (tl-next-numeric cs) (modulo (+ cs 1) 3))

; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render RED)
  (overlay/align "center" "center" (light RED) (empty-scene 90 30)))
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


; Number -> Image
; Draws 3 color traffic light
(define (light color)
  (overlay/align "center" "center"                 
   (beside (circle 10 (if (equal? RED color) "solid" "outline") "red") SPACER
           (circle 10 (if (equal? YELLOW color) "solid" "outline") "yellow") SPACER
           (circle 10 (if (equal? GREEN color) "solid" "outline") "green"))
   BACKGROUND
   )
)

(traffic-light-simulation RED)