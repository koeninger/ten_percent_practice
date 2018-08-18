#! /usr/local/bin/racket
#lang racket
(require 2htdp/image)

(define (image-area image)
  (* (image-height image) (image-width image))
)

(image-area (rectangle 10 20 "solid" "blue"))
