;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex47) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define MAX 100)

(define WIDTH-OF-WORLD MAX)
(define BACKGROUND (empty-scene WIDTH-OF-WORLD 20))


; WorldState -> Image
; places the image of the car x pixels from 
; the left margin of the BACKGROUND image 
(define (render x)
  (place-image (rectangle x 20 "solid" "red") 0 0  BACKGROUND))

; WorldState -> WorldState
; adds 3 to x to move the cat right 
(define (tock x)
  (- x .1))

; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
    ))


(main MAX)