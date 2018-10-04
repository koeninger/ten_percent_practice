;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex055) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)

(define HEIGHT 300) ; distances in pixels
(define WIDTH  100)
(define YDELTA 3)

(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))

(define CENTER (/ (image-height ROCKET) 2))


; LRCD -> Image
; renders the state as a resting or flying rocket
(check-expect (show "resting") (place-rocket HEIGHT))
(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
   10 (* 3/4 WIDTH)
   (place-rocket HEIGHT)))
(check-expect (show 53) (place-rocket 53))
(define (show x)
  (cond
    [(string? x) (place-rocket HEIGHT)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
        10 (* 3/4 WIDTH)
        (place-rocket HEIGHT))]
    [(>= x 0) (place-rocket x)]))

; Number -> Image
; places the ROCKET on BACKG
(check-expect (place-rocket 53)
   (place-image ROCKET 10 (- 53 CENTER) BACKG))
(define (place-rocket x)
  (place-image ROCKET 10 (- x CENTER) BACKG))

; LRCD KeyEvent -> LRCD
; starts the countdown when space bar is pressed,
; if the rocket is still resting
(define (launch x ke)
  x)

; LRCD -> LRCD
; raises the rocket by YDELTA,
;  if it is moving already
(define (fly x)
  x)
