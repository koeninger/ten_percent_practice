;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |51|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define BACKGROUND (rectangle 200 200 "solid" "black"))

; String -> Image
; Draws single traffic light
(define (light color)
  (overlay/align "center" "center"
   (circle 80 "solid" color)
   BACKGROUND
   )
)

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "yellow") "red")
(check-expect (traffic-light-next "green") "yellow")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))


; Light -> Light
; Returns an Light state depending on the current one
(define (tock x)
  (traffic-light-next x)
)

; Light state -> Image
; Retuns an image depending on the state string
(define (render as)
  (light as)
)

(define (main as)
   (big-bang as
     [on-tick tock 2] ; tick every 2 seconds
     [to-draw render]
  )
)

; start with a red light
(main "red")