#lang racket

(require 2htdp/image)

(define scale 1)

(above (triangle (* 40 scale) "solid" "red")
       (rectangle (* 40 scale) (* 30 scale) "solid" "black"))