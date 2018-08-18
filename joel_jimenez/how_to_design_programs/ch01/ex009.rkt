#! /usr/local/bin/racket
#lang racket
(require 2htdp/image)

(define (convert in)
  (if (string? in)
    (string-length in)
    (if (image? in)
      (* (image-height in) (image-width in))
      (if (number? in)
        (if (> in 0)
          (- in 1)
          in
        )
        (if (boolean? in)
          (if in 10 20)
          "?"
        )
      )
    )
  )
)

(convert "test")
(convert "")
(convert (triangle 10 "solid" "blue"))
(convert 100)
(convert 0)
(convert -5)
(convert #true)
(convert #false)
(convert pi)
(convert (void))
