;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |39|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define WHEEL-RADIUS 50)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define SPACE
    (rectangle WHEEL-DISTANCE WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS
    (beside WHEEL SPACE WHEEL))
(define BODY-DISTANCE (+ (* WHEEL-RADIUS 4) WHEEL-DISTANCE))
(define BODY-HEIGHT (* WHEEL-RADIUS 1.5))
(define BODY-MIDDLE
  (rectangle BODY-DISTANCE BODY-HEIGHT "solid" "red"))
(define BODY-TOP
  (rectangle WHEEL-DISTANCE BODY-HEIGHT "solid" "red"))
(define BODY
  (above BODY-TOP BODY-MIDDLE))
(define CAR
  (above BODY BOTH-WHEELS))