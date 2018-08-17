;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex06) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; Change scale
(define size 50)

(define trunk (rectangle size (* size 2) "solid" "Brown"))
(define (pine x) (triangle (* size x) "solid" "ForestGreen"))

(overlay/align/offset "middle" "top"
  (pine 1)
  0 (/ size 3)
  (overlay/align/offset "middle" "top"
    (pine 2)
    0 (/ size 2)
    (overlay/xy
      (pine 3)
      size (* size 2)
      trunk
    )
  )
)
