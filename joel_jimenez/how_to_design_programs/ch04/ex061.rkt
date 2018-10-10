;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex061) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; An S-TrafficLight is one of:
; – RED
; – GREEN
; – YELLOW
(define RED 0)
(define GREEN 1)
(define YELLOW 2)

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
(check-expect (light-on RED RED) "solid")
(check-expect (light-on GREEN YELLOW) "outline")
(define (light-on cs color)
  (if (= color cs)
    "solid"
    "outline"))

; TrafficLight -> Image
; creates the light for a given image
(check-expect (light RED RED) (circle SIZE "solid" (tl-color RED)))
(check-expect (light GREEN YELLOW) (circle SIZE "outline" (tl-color YELLOW)))
(define (light cs color)
  (circle SIZE (light-on cs color) (tl-color color)))

; TrafficLight -> Color
; yields the color value, given current state cs
(check-expect (tl-color GREEN) "green")
(check-expect (tl-color YELLOW) "yellow")
(check-expect (tl-color RED) "red")
(define (tl-color cs)
  (cond
    [(= GREEN cs) "green"]
    [(= YELLOW cs) "yellow"]
    [(= RED cs) "red"]))

; N-TrafficLight -> N-TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next-symbolic RED) GREEN)
(check-expect (tl-next-symbolic GREEN) YELLOW)
(check-expect (tl-next-symbolic YELLOW) RED)
(define (tl-next-symbolic cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))

; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render RED) (place-images
    (list (light RED RED)
      (light RED YELLOW)
      (light RED GREEN))
   LIGHT-POS BACKGROUND))
(define (tl-render current-state)
  (place-images
    (list (light current-state RED)
      (light current-state YELLOW)
      (light current-state GREEN))
   LIGHT-POS BACKGROUND))

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next-symbolic 1]))

(traffic-light-simulation RED)
