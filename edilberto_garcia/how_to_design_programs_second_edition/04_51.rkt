;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_51) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 51. Design a big-bang program that simulates a traffic light
;    for a given duration. The program renders the state of a traffic
;    light as a solid circle of the appropriate color, and it changes
;    state on every clock tick. What is the most appropriate initial
;    state? Ask your engineering friends.


(require 2htdp/universe)
(require 2htdp/image)



(define background (rectangle 50 100 "outline" "grey"))

;(define light (



; tock
; render


; AnimationState -> Image
; renders the traffic light
(define (render current_state)
 (circle 50 "solid" current_state)
)



(define (tock current_state)
    (cond
        [(string=? "green"  current_state) "yellow"]
        [(string=? "yellow" current_state) "red"]
        [(string=? "red"    current_state) "green"]
))


(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
))