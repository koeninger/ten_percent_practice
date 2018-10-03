;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex053) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; An LR (short for launching rocket) is one of:
; – "resting"
; – NonnegativeNumber
; interpretation "resting" represents a grounded rocket
; a number denotes the height of a rocket in flight

(define SIZE 10)
(define WIDTH (* SIZE 3))
(define HEIGHT (* WIDTH 2))
(define SCENE (empty-scene WIDTH HEIGHT))
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
(check-expect (keh "resting" " ") 0)
(check-expect (keh 5 " ") 5)
(define (keh ws ke)
  (cond
    [(and (string? ws) (string=? " " ke)) 0]
    [else ws]))

; WorldState -> WorldState
; adds 3 to the given number; otherwise given number
(check-expect (tick 5) 8)
(check-expect (tick "resting") "resting")
(define (tick ws)
  (cond
    [(and (integer? ws) (>= ws 0)) (+ ws 3)]
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
(check-expect (render 5) (place-image/align ROCKET (/ WIDTH 2) (placement 5) "center" "bottom" SCENE))
(define (render ws)
  (place-image/align ROCKET
    (/ WIDTH 2)
    (placement ws)
    "center" "bottom"
    SCENE))

(main "resting")
