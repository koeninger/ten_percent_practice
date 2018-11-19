;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex59b) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define RED-POSN (make-posn 25 20))
(define YELLOW-POSN (make-posn 65 20))
(define GREEN-POSN (make-posn 105 20))

(define BACKGROUND
  (place-images
   (list
    (circle 15 "outline" "red")
    (circle 15 "outline" "yellow")
    (circle 15 "outline" "green"))
   (list
    RED-POSN
    YELLOW-POSN
    GREEN-POSN)
   (empty-scene 130 40 "black")))

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
(define (tl-render current-state)
  (place-images
   (list (circle 15 "solid" current-state))
   (list
    (cond
      [(string=? current-state "red") RED-POSN]
      [(string=? current-state "green") GREEN-POSN]
      [(string=? current-state "yellow") YELLOW-POSN]))
   BACKGROUND))

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

(traffic-light-simulation "red")

