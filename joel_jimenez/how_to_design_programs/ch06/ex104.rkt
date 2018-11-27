;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |104|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct vehicle [passengers license-number mpg])
; A Vehicle is a structure:
;   (make-vehicle Number String Number)
; INTERPRETATION (make-vehicle p l m):
;   p = number of passengers that it can carry
;   l = its license plate number
;   m = its fuel consumption (miles per gallon)

; (define (consume-vehicle v)
;   (vehicle-passengers v) ... (vehicle-license-number v) ... (vehicle-mpg v))
