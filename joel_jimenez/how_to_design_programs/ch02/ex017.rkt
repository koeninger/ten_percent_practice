#! /usr/local/bin/racket
#lang racket
(require 2htdp/image)

(define (image-classify image)
  (define height (image-height image))
  (define width (image-width image))

  (if (>= height width)
    (if (= height width)
      "square"
      "tall"
    )
    "wide"
  )
)

(image-classify (rectangle 10 20 "solid" "blue"))
(image-classify (rectangle 15 15 "solid" "green"))
(image-classify (rectangle 20 10 "solid" "red"))
