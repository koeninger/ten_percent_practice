#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

(define RED "red")
(define YELLOW "yellow")
(define GREEN "green")

(define RADIUS 100)
(define RED-LIGHT (circle RADIUS "solid" RED))
(define YELLOW-LIGHT (circle RADIUS "solid" YELLOW))
(define GREEN-LIGHT (circle RADIUS "solid" GREEN))
(define BLACK-LIGHT (circle RADIUS "solid" "black"))

; TrafficLight -> Image
; renders the current state cs as an image
(define (tl-render current-state)
  (above/align "middle"
                (cond
                  [(equal? current-state RED) RED-LIGHT]
                  [else BLACK-LIGHT])
                (cond
                  [(equal? current-state YELLOW) YELLOW-LIGHT]
                  [else BLACK-LIGHT])
                (cond
                  [(equal? current-state GREEN) GREEN-LIGHT]
                  [else BLACK-LIGHT])))

; N-TrafficLight -> N-TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next RED) GREEN)
(check-expect (tl-next GREEN) YELLOW)
(check-expect (tl-next YELLOW) RED)
(define (tl-next cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

(test)
(traffic-light-simulation YELLOW)