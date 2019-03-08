;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex152) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define CIRCLE (circle 5 "solid" "red"))

(check-expect (col 2 CIRCLE) (above CIRCLE CIRCLE empty-image))
(check-expect (col 1 CIRCLE) (above CIRCLE empty-image))

; N Image -> Image
; produces column of n copies of image
(define (col x i)
  (cond
    [(zero? x) empty-image]
    [else (above i (col (sub1 x) i))]))


(check-expect (row 2 CIRCLE) (beside CIRCLE CIRCLE empty-image))
(check-expect (row 1 CIRCLE) (beside CIRCLE empty-image))
; N Image -> Image
; produces row of n copies of image
(define (row x i)
  (cond
    [(zero? x) empty-image]
    [else (beside i (col (sub1 x) i))]))