;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 03_39) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 39. Good programmers ensure that an image such as CAR can be
;  enlarged or reduced via a single change to a constant definition.
(define WHEEL-RADIUS 10)

;The definition of WHEEL-DISTANCE is based on the wheel’s radius.
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

;  Hence, changing WHEEL-RADIUS from 5 to 10 doubles the size of the car image.
;  This kind of program organization is dubbed single point of control, and good
;  design employs this idea as much as possible.
;Develop your favorite image of an automobile so that WHEEL-RADIUS
;  remains the single point of control. 



(require 2htdp/image)

(define CAR_BASE (rectangle 100 30 "solid" "silver"))
 
(define CAR_WHEEL (circle WHEEL-RADIUS "solid" "black"))

(define WHEELS (pl
   
(place-image CAR_WHEEL 15  20 CAR_BASE)