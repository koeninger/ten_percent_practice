;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4.7_finite_state) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/universe)

; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(define (tl-next cs)
  (cond
    [(string=? cs "red") "green"]
    [(string=? cs "green") "yellow"]
    [(string=? cs "yellow") "red"]))

(define RED-POSN (make-posn 25 20))
(define YELLOW-POSN (make-posn 65 20))
(define GREEN-POSN (make-posn 105 20))

(define BACKGROUND
  (place-images
   (list
    (circle 15 "outline" "red")
    (circle 15 "outline" "yellow")
    (circle 15 "outline" "green")
   (list
    RED-POSN
    YELLOW-POSN
    GREEN-POSN)
   (empty-scene 130 40))))

; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render "red") 23)
(check-expect (tl-render "yellow") 23)
(define (tl-render current-state)
  (empty-scene 90 30))

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))
