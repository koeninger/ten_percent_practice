;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |36|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; Image -> Number
; Returns the number of pixels in a given image
; given (empty-scene 100 100), expect 10000
(define (image-area img)
  (* (image-height img) (image-width img))
)

(image-area (empty-scene 100 100))