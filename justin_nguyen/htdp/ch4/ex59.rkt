;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex59) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume 


; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

(define BOX-HEIGHT 30)
(define BOX-WIDTH (* BOX-HEIGHT 3))

(define LIGHT-HEIGHT (/ BOX-HEIGHT 2))

(define TL-BOX (empty-scene BOX-WIDTH BOX-HEIGHT))


; basic Image of traffic light box (all off)
(define base-light
  (place-image (circle 10 "outline" "red") (* BOX-WIDTH 1/6) LIGHT-HEIGHT
  (place-image (circle 10 "outline" "yellow") (* BOX-WIDTH 1/2) LIGHT-HEIGHT
  (place-image (circle 10 "outline" "green") (* BOX-WIDTH 5/6) LIGHT-HEIGHT TL-BOX))))

; TrafficLight -> Image
; yields image of traffic light given state s
(define (tl-render s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

;TrafficLight -> TrafficLight
; yields next state, for a given state s
(define (tl-next s) ...)


; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))