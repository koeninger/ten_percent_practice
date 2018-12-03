#lang racket

(require 2htdp/image)
(require 2htdp/universe)

(define RADIUS 100)
(define RED-LIGHT (circle RADIUS "solid" "red"))
(define YELLOW-LIGHT (circle RADIUS "solid" "yellow"))
(define GREEN-LIGHT (circle RADIUS "solid" "green"))
(define BLACK-LIGHT (circle RADIUS "solid" "black"))

(define (tock time)
  (cond
    [(< time 3) (+ time .01)]
    [else 0]))

(define (render time)
  (above/align "middle"
                (cond
                  [(<= 0 time 1) RED-LIGHT]
                  [else BLACK-LIGHT])
                (cond
                  [(<= 1 time 2) YELLOW-LIGHT]
                  [else BLACK-LIGHT])
                (cond
                  [(<= 2 time 3) GREEN-LIGHT]
                  [else BLACK-LIGHT])))

(define (traffic-light)
   (big-bang 0
     [on-tick tock]
     [to-draw render]))

(traffic-light)