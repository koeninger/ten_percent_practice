#! /usr/local/bin/racket
#lang racket

(require 2htdp/image)

; Data will be represented as an Image
; Image -> Number
; Computes the area of an Image img
; given:
;  (rectangle 4 7 "solid" "red")
; expect:
;  28
; given:
;  (circle 3 "solid" "blue")
; expect:
;  36
(define (image-area img)
  (* (image-width img) (image-height img)))

(image-area (rectangle 4 7 "solid" "red"))
(image-area (circle 3 "solid" "blue"))
