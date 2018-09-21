;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex047) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A WorldState is a Number.
; interpretation the width in pixels of
; the happiness-gauge in the scene

(define MAX-Y 10)
(define MAX-X 100)

(define BACKGROUND
  (empty-scene MAX-X MAX-Y))


; WorldState -> Image
; Returns the image of a red rectangle of width ws
(define (happiness-gauge ws)
  (rectangle ws MAX-Y "solid" "red"))

; WorldState -> Image
; places the image of the happiness-gauge inside,
; in the middle of the BACKGROUND image
(define (render ws)
  (place-image
    (happiness-gauge ws) (/ MAX-X 2) (/ MAX-Y 2) BACKGROUND))

; WorldState -> WorldState
; Decreases happiness  by -0.1 it never
; falls below 0 and max value is MAX-X
; given: 100, expect: 99.9
; given: 0, expect: 0
(define (tock ws)
  (cond [(<= ws 0) 0]
    [else (if (> ws MAX-X)
      MAX-X (- ws 0.1))]))

; WorldState, key-event? -> WorldState
; Every time the down arrow key is pressed, happiness increases by 1/5
; and every time the up arrow is pressed, happiness jumps by 1/3.
; given: 30, "up", expect: 40
; given: 50, "down", expect: 60
; given: 100, "left", expect: 100
(define (press ws key)
  (cond
    [(key=? key "up") (+ ws (/ ws 3))]
    [(key=? key "down") (+ ws (/ ws 5))]
    [else ws]))

; WorldState -> WorldState
; launches the program from some initial state that
; displays a “happiness gauge"
(define (gauge-prog ws)
  (big-bang ws
    [on-tick tock]
    [on-key press]
    [to-draw render]))

(check-expect (tock 100) 99.9)
(check-expect (tock 0) 0)
(check-expect (press 30 "up") 40)
(check-expect (press 50 "down") 60)
(check-expect (press 100 "left") 100)

(gauge-prog 100)
