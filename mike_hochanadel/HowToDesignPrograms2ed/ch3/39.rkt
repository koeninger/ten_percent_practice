;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |39|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Car measurements
; Wheel size
(define WHEEL-RADIUS 5)
; Distance between the two wheels of the car
(define WHEEL-DISTANCE
  (* WHEEL-RADIUS 5))
; How long the body of the car is
(define BODY-DISTANCE
  (+ (* WHEEL-RADIUS 4) WHEEL-DISTANCE))
; How tall parts of the body are
(define BODY-HEIGHT
  (* WHEEL-RADIUS 1.5))

; Car graphic components
; Car wheel
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
; Space between wheels
(define SPACE
  (rectangle WHEEL-DISTANCE WHEEL-RADIUS "solid" "white"))
; The undercarriage of a car
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
; The main body of the car
(define BODY-MIDDLE
  (rectangle BODY-DISTANCE BODY-HEIGHT "solid" "red"))
; The top part of the body of the car
(define BODY-TOP
  (rectangle WHEEL-DISTANCE BODY-HEIGHT "solid" "red"))
; The body of the car
(define BODY
  (above BODY-TOP BODY-MIDDLE))

; Car has a body and wheels underneath
(define CAR
  (above BODY BOTH-WHEELS))