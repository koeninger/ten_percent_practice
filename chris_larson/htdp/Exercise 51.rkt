;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 51|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; definitions
(define WIDTH-OF-WORLD 40)
(define HEIGHT-OF-WORLD 70)
(define red (circle 10 "solid" "red"))
(define yellow (circle 10 "solid" "yellow"))
(define green (circle 10 "solid" "green"))
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))

; AnimationState-> AnimationState
; for each tick of the clock, big-bang obtains the next
; state of the world from (clock-tick-handler cw)
; given: 20, expect 23
; given: 78, expect 81
(define (tock state)
  (traffic-light-next state))
(check-expect (tock "green") "yellow")
(check-expect (tock "yellow") "red")

; AnimationState -> Image
; when needed, big-bang obtains the image of the current
; state of the world by evaluating (render cw)
(define (render as)
  (place-image (traffic-light-image (traffic-light-next as)) 20 20 BACKGROUND))

(define (traffic-light-image s)
  (cond
    [(string=? "red" s) red]
    [(string=? "green" s) green]
    [(string=? "yellow" s) yellow]))

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; AnimationState -> AnimationState
; launches the program form some initial state
(define (main state)
  (big-bang state
    [on-tick tock]
    [to-draw render]))
