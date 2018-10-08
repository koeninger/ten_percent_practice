;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 60|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; definitions
; definitions
(define WIDTH-OF-WORLD 40)
(define HEIGHT-OF-WORLD 70)
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))
(define red (place-image (circle 10 "solid" "red") 20 20 BACKGROUND))
(define yellow (place-image (circle 10 "solid" "yellow") 20 35 BACKGROUND))
(define green (place-image (circle 10 "solid" "green") 20 50 BACKGROUND))
(define RED 0)
(define GREEN 1)
(define YELLOW 2)

; An N-TrafficLight is one of:
; – 0 interpretation the traffic light shows red
; – 1 interpretation the traffic light shows green
; – 2 interpretation the traffic light shows yellow
; N-TrafficLight -> N-TrafficLight
; yields the next state, given current state cs
(define (tl-next-symbolic cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))


; TrafficLight -> Image
; renders the current state cs as an image
(define (tl-render-numeric current-state)
    (cond
    [(equal? RED current-state) red]
    [(equal? GREEN current-state) green]
    [(equal? YELLOW current-state) yellow]))
(check-expect (tl-render-numeric RED) red)
(check-expect (tl-render-numeric GREEN) green)
(check-expect (tl-render-numeric YELLOW) yellow)

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render-numeric]
    [on-tick tl-next-symbolic 1]))
