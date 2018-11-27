;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex61) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define RED 0)
(define GREEN 1)
(define YELLOW 2)
 
; An S-TrafficLight is one of:
; – RED
; – GREEN
; – YELLOW


; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(define (tl-next cs)
  (traffic-light-next cs))
 
; TrafficLight -> Image
; renders the current state cs as an image
(define (tl-render current-state)
  (place-images/align
   (list (circle 10 (if (= current-state GREEN) "solid" "outline") "green")
         (circle 10 (if (= current-state YELLOW) "solid" "outline") "yellow")
         (circle 10 (if (= current-state RED) "solid" "outline") "red"))
   (list (make-posn 15 15)
         (make-posn 45 15)
         (make-posn 75 15)
         )
   "center" "center"
  (empty-scene 90 30)
  ))

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))


; TrafficLight -> TrafficLight
; yields the next state given current state s
(define (traffic-light-next cs)
 (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))




(traffic-light-simulation 0)