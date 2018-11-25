#lang racket

(require 2htdp/image)

(define (image-classify img)
   (cond
     [(> (image-height img) (image-width img)) "tall"]
     [(> (image-width img) (image-height img)) "wide"]
     [else "square"]))