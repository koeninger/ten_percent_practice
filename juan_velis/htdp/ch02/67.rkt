;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |67|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")

(make-balld 100 "up")
(make-balld (+ 25 SPEED) "down")
(make-balld 0 "up")

(define-struct vel [deltax deltay])

(define ball1
  (make-balld (make-posn 30 40) (make-vel -10 5)))
