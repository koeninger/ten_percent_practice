;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex60) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(define (tl-next cs)
  (tl-next-numeric cs))
 
; TrafficLight -> Image
; renders the current state cs as an image
(define (tl-render current-state)
  (place-images/align
   (list (circle 10 (if (= current-state 1) "solid" "outline") "green")
         (circle 10 (if (= current-state 2) "solid" "outline") "yellow")
         (circle 10 (if (= current-state 0) "solid" "outline") "red"))
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
(check-expect (traffic-light-next "red") "green")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; An N-TrafficLight is one of:
; – 0 interpretation the traffic light shows red
; – 1 interpretation the traffic light shows green
; – 2 interpretation the traffic light shows yellow

; N-TrafficLight -> N-TrafficLight
; yields the next state, given current state cs
(define (tl-next-numeric cs) (modulo (+ cs 1) 3))

(traffic-light-simulation 0)