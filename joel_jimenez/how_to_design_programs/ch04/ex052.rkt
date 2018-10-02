;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex052) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO

(define WIDTH 300) ; distances in terms of pixels
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (overlay (circle 10 "solid" "green")
  (rectangle 30 5 "solid" "red")))

; WorldState -> WorldState
(define (main y0)
  (big-bang y0
     [on-tick nxt]
     [to-draw render/status]))

; WorldState -> WorldState
; computes next location of UFO
(check-expect (nxt 11) 14)
(define (nxt y)
  (+ y 3))

; WorldState -> Image
; places UFO at given height into the center of MTSCN
(check-expect (render 11) (place-image UFO (/ WIDTH 2) 11 MTSCN))
(define (render y)
  (place-image UFO (/ WIDTH 2) y MTSCN))

; WorldState -> Image
; describes the status of the UFO based on the WorldState
(check-expect (status-line 0) (text "descending" 11 "green"))
(check-expect (status-line CLOSE) (text "closing in" 11 "orange"))
(check-expect (status-line HEIGHT) (text "landed" 11 "red"))
(define (status-line y)
  (cond
    [(< y CLOSE)
      (text "descending" 11 "green")]
    [(< y HEIGHT)
      (text "closing in" 11 "orange")]
    [else
      (text "landed" 11 "red")]))

; WorldState -> Image
; places UFO at given height into the center of MTSCN along with UFO status
(check-expect (render/status 10) (place-image (status-line 10)(/ WIDTH 2) 10 (render 10)))
(define (render/status y)
  (place-image (status-line y)
    (/ WIDTH 2) 10 (render y)))

(main 10)
#|
Exercise 52. Which integers are contained in the four intervals above?
[3,5] -> 3, 4, 5
(3,5] -> 3, 4
[3,5) -> 4, 5
(3,5) -> 4
|#
