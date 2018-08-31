;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |33|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

; Number String Image -> Image 
; adds s to img,
; y pixels from the top and 10 from the left 
(define (add-image y s img)
  (empty-scene 100 100))

; Number -> Number
; computes the area of a square with side len 
; given: 2, expect: 4
; given: 7, expect: 49
(define (area-of-square len)
  (sqr len))

(area-of-square 2)
(area-of-square 7)
(area-of-square 8)
