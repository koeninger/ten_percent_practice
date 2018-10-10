;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex059) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three
; possible states that a traffic light may assume

(define SIZE 10)
(define WIDTH (* SIZE 9))
(define HEIGHT (* SIZE 3))
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define Y (/ HEIGHT 2))

; TrafficLight -> ImageMode
; controls if the light is "on" or not for given state
(check-expect (light-on "red" "red") "solid")
(check-expect (light-on "green" "yellow") "outline")
(define (light-on cs color)
  (if (string=? color cs)
    "solid"
    "outline"))

; TrafficLight -> Image
; creates the light for a given image
(check-expect (light "red" "red") (circle SIZE "solid" "red"))
(check-expect (light "green" "yellow") (circle SIZE "outline" "yellow"))
(define (light cs color)
  (circle SIZE (light-on cs color) color))

; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next "red") "green")
(check-expect (tl-next "green") "yellow")
(check-expect (tl-next "yellow") "red")
(define (tl-next cs)
  (cond
    [(string=? "red" cs) "green"]
    [(string=? "green" cs) "yellow"]
    [(string=? "yellow" cs) "red"]))

; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render "red") (place-images
    (list (circle SIZE (light-on "red" "red") "red")
      (circle SIZE (light-on "red" "yellow") "yellow")
      (circle SIZE (light-on "red" "green") "green"))
   (list (make-posn (/ WIDTH 5) Y)
         (make-posn (/ WIDTH 2) Y)
         (make-posn (- WIDTH (/ WIDTH 5)) Y))
   BACKGROUND))
(define (tl-render current-state)
  (place-images
    (list (light current-state "red")
      (light current-state "yellow")
      (light current-state "green"))
   (list (make-posn (/ WIDTH 5) Y)
         (make-posn (/ WIDTH 2) Y)
         (make-posn (- WIDTH (/ WIDTH 5)) Y))
   BACKGROUND))

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

(traffic-light-simulation "red")
