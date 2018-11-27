#lang racket

(require 2htdp/image)

(define (image-area img)
  (* (image-width img) (image-height img)))