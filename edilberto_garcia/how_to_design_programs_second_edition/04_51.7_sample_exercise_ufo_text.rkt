;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_51.7_sample_exercise_ufo_text) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Sample Problem Add a status line. It says “descending” when the
;    UFO’s height is above one third of the height of the canvas. It
;    switches to "closing in" below that. And finally, when the UFO has
;    reached the bottom of the canvas, the status notifies the player
;    that the UFO has “landed.”




; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO

(require 2htdp/universe)
(require 2htdp/image)

(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (overlay (circle 10 "solid" "green") (ellipse 55 10 "solid" "green") ))

; WorldState -> WorldState
(define (main y0)
  (big-bang y0
     [on-tick nxt]
     [to-draw render]))
 
; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 14)
(define (nxt y)
(cond
  [(<= y HEIGHT) (+ y 3)]
  [else HEIGHT]
))

; WorldState -> Image
; computes the UFO status text
(check-expect (ufo-status 500) (text "descending" 24 "orange"))
(check-expect (ufo-status (- HEIGHT 10)) (text "descending" 24 "orange"))
(check-expect (ufo-status 10) (text "landed" 24 "orange"))
(define (ufo-status y)

(text 
    (cond
        [(and (> y CLOSE) (<= y HEIGHT)) "descending" ]
        [(and (< y CLOSE) (>= y HEIGHT))  "closing in" ]
        [else "landed"]
    )
    24
    "orange"
)
)

; WorldState -> Image
; places UFO at given height into the center of MTSCN
; Displays the text status of the UFO
 ;(check-expect (render 11) (place-image UFO CLOSE 11 MTSCN))
(define (render y)
  (place-image (ufo-status y) 50 50
  (place-image UFO CLOSE y MTSCN)))