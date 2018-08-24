;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ch2-4) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; definitions
(define BACKGROUND (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

; functions
; what does the function compute?
(define (number->square s)
  (square s "solid" "red"))
(define (reset s ke)
  100)
(define (main y)
  (big-bang y
    [on-tick sub1]
    [stop-when zero?]
    [to-draw place-dot-at]
    [on-key stop]))
(define (place-dot-at y)
  (place-image DOT 50 y BACKGROUND))
(define (stop y ke)
  0)
; Number String Image -> Image
; adds s to img, y pixels from top, 10 pixels to the left
; given: 
;    5 for y, 
;    "hello" for s, and
;    (empty-scene 100 100) for img
; expected: 
;    (place-image (text "hello" 10 "red") 10 5 ...)
;    where ... is (empty-scene 100 100)
(define (add-image y s img)
  (place-image (text s 10 "red") 10 y img))

; Number -> Number
; computes the area of a square with side len
; given: 2, expect: 4
; given: 7, expect: 49
(define (area-of-square len)
  (sqr len))


; scratch
(number->square 5)
(number->square 10)
(number->square 20)
; (big-bang 100 [to-draw number->square])
; (big-bang 100
;  [to-draw number->square]
;  [on-tick sub1]
;  [stop-when zero?]
;  [on-key reset])
(place-dot-at 89)
(stop 89 "q")
; (main 90)
(area-of-square 2)
(area-of-square 7)