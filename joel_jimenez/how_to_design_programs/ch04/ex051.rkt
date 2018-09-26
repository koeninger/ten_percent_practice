;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex051) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three
; possible states that a traffic light may assume

(define LIGHT-SIZE 20)

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; TrafficLight -> Image
; renders the state of a traffic light as
; a solid circle of the appropriate color
(check-expect (render "red") (circle LIGHT-SIZE "solid" "red"))
(define (render s)
  (circle LIGHT-SIZE "solid" s))

; TrafficLight -> TrafficLight
; changes the state of a traffic light on every clock tick
(check-expect (traffic-light-next "red") "green")
(define (tock s)
  (traffic-light-next s))

; TrafficLight -> TrafficLight
; launches the program from some initial state
(define (main s)
   (big-bang s
     [on-tick tock]
     [to-draw render]))

(render "red")
