;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 67|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))


(define-struct ball [location velocity])
; (make-ball 10 -3)

(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")
(make-balld 4 "down")

(define-struct vel [deltax deltay])
(define ball1
  (make-ball (make-posn 30 40) (make-vel -10 5)))
