#lang racket

(require 2htdp/image)
(require 2htdp/universe)

(define RED-LIGHT (circle 100 "solid" "red"))
(define YELLOW-LIGHT (circle 100 "solid" "yellow"))
(define GREEN-LIGHT (circle 100 "solid" "green"))
(define BLACK-LIGHT (circle 100 "solid" "black"))

(define (tock time)
  (cond
    [(< time 3) (+ time .01)]
    [else 0]))

(define (render time)
  (above/align "middle"
                (cond
                  [(and (>= time 0) (< time 1)) RED-LIGHT]
                  [else BLACK-LIGHT])
                (cond
                  [(and (>= time 1) (< time 2)) YELLOW-LIGHT]
                  [else BLACK-LIGHT])
                (cond
                  [(and (> time 2) (<= time 3)) GREEN-LIGHT]
                  [else BLACK-LIGHT])))

(define (traffic-light)
   (big-bang 0
     [on-tick tock]
     [to-draw render]))

(traffic-light)