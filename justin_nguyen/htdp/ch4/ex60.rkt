;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex60) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An N-TrafficLight is one of:
; – 0 interpretation the traffic light shows red
; – 1 interpretation the traffic light shows green
; – 2 interpretation the traffic light shows yellow

; N-TrafficLight -> N-TrafficLight
; yields next state, for a given state s
(check-expect (tl-next-numeric 0) 1)
(check-expect (tl-next-numeric 1) 2)
(check-expect (tl-next-numeric 2) 0)
(define (tl-next-numeric cs) (modulo (+ cs 1) 3))

; Though the new code is shorter and simpler, I think the intent is less clear.
; The previous version used text to represent color/state, which is more clear than
; mapping arbitrary numbers to the states. Anyone can look at tl-next and understand that
; the string "yellow" indicates a yellow light. In the numeric version, you have to
; either remember or look up that 2 maps to yellow.

