;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex060) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; An N-TrafficLight is one of:
; – 0 interpretation the traffic light shows red
; – 1 interpretation the traffic light shows green
; – 2 interpretation the traffic light shows yellow

(define SIZE 10)
(define WIDTH (* SIZE 9))
(define HEIGHT (* SIZE 3))
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define Y (/ HEIGHT 2))
(define LIGHT-POS (list (make-posn (/ WIDTH 5) Y)
  (make-posn (/ WIDTH 2) Y)
  (make-posn (- WIDTH (/ WIDTH 5)) Y)))

; TrafficLight -> ImageMode
; controls if the light is "on" or not for given state
(check-expect (light-on 2 2) "solid")
(check-expect (light-on 0 1) "outline")
(define (light-on cs color)
  (if (= color cs)
    "solid"
    "outline"))

; TrafficLight -> Image
; creates the light for a given image
(check-expect (light 2 2) (circle SIZE "solid" (tl-color 2)))
(check-expect (light 0 1) (circle SIZE "outline" (tl-color 1)))
(define (light cs color)
  (circle SIZE (light-on cs color) (tl-color color)))

; TrafficLight -> Color
; yields the color value, given current state cs
(check-expect (tl-color 0) "green")
(check-expect (tl-color 1) "yellow")
(check-expect (tl-color 2) "red")
(define (tl-color cs)
  (cond
    [(= 0 cs) "green"]
    [(= 1 cs) "yellow"]
    [(= 2 cs) "red"]))

; N-TrafficLight -> N-TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next-numeric 0) 1)
(check-expect (tl-next-numeric 1) 2)
(check-expect (tl-next-numeric 2) 0)
(define (tl-next-numeric cs)
  (modulo (+ cs 1) 3))

; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render 2) (place-images
    (list (light 2 2)
      (light 2 1)
      (light 2 0))
   LIGHT-POS BACKGROUND))
(define (tl-render current-state)
  (place-images
    (list (light current-state 2)
      (light current-state 1)
      (light current-state 0))
   LIGHT-POS BACKGROUND))

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next-numeric 1]))

(traffic-light-simulation 2)
