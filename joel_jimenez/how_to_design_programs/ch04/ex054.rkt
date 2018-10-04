;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex054) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)

(define SIZE 10)
(define WIDTH (* SIZE 3))
(define HEIGHT (* WIDTH 2))
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define ROCKET (above
  (triangle SIZE "solid" "red")
  (overlay/align "middle" "bottom"
    (rectangle SIZE WIDTH "solid" "red")
    (triangle (* SIZE 2) "solid" "black"))))


; WorldState -> WorldState
(define (main ws)
  (big-bang ws
    [on-key keh]
    [on-tick tick]
    [to-draw render]))


; WorldState, KeyEvent -> Position
; checks for spacebar key press to launch rocket; 0 otherwise
(check-expect (keh "resting" " ") -3)
(check-expect (keh 5 " ") 5)
(define (keh ws ke)
  (cond
    [(and (string? ws) (string=? " " ke)) -3]
    [else ws]))

; WorldState -> WorldState
; adds 3 to the given number; otherwise given number
(check-expect (tick 5) 8)
(check-expect (tick "resting") "resting")
(define (tick ws)
  (cond
    [(integer? ws)
      (cond
        [(< ws 0)(+ ws 1)]
        [else (+ ws 3)])]
    [else ws]))

; WorldState -> Number
; position of rocket rocket based on WorldState
(check-expect (placement 5) (- HEIGHT 5))
(check-expect (placement "resting") HEIGHT)
(define (placement ws)
  (cond
    [(and (integer? ws) (>= ws 0))
     (- HEIGHT ws)]
    [else HEIGHT]))

; WorldState -> Image
; places rocket at WorldState; otherwise places at position 0
(check-expect (render 5) (place-image/align ROCKET (/ WIDTH 2) (placement 5) "center" "bottom" BACKGROUND))
(define (render ws)
  (place-image/align ROCKET
    (/ WIDTH 2)
    (placement ws)
    "center" "bottom"
    BACKGROUND))

(main "resting")

#|
(string=? "resting" x) will crash if x  is a number
|#
