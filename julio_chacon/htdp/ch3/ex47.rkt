;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex47) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


; WS is a Number representing seconds that have passed in the world

; WS -> Image
; ads image to WS
(define (render per)
  (place-image/align
   (rectangle (* per BG-WIDTH) BG-HEIGHT "solid" "red")
      0 0  "left" "top"
   BACKGROUND))

; WS -> WS
; modifies WS and returns it
(define tock 
   (if (>= ws (+ BG-WIDTH (image-width cat1)))
        0
        (+ ws 3))
)

(define BG-HEIGHT 50)
(define BG-WIDTH 200)

(define BACKGROUND
  (empty-scene BG-WIDTH BG-HEIGHT))

(define (LEVEL size)
  (rectangle (* size BG-WIDTH) BG-HEIGHT "solid" "red")
  )


; WS -> WS
; launches the program from some initial state 
;(define (main ws)
 ; (big-bang ws
  ;  [on-tick tock]
   ; [to-draw render]))


;(main 0)

;level

(render .10)

(render .50)

(render 1)