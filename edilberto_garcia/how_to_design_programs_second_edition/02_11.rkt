;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02_11) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 11. Define a function that consumes two numbers, x and y,
;and that computes the distance of point (x,y) to the origin.

(define (distance_from_origin x y)(
  sqrt (+ (expt x 2) (expt y 2))
))