;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_67) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 67. Here is another way to represent bouncing balls:

(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")


;Interpret this code fragment and create other instances of balld.


; This defines a ball as having a location and direction, except the speed is set as a constant
;  so the direction parameter is is just the cardinal direction

(make-balld 1000 "up")