;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02_30) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 30. Define constants for the price optimization program at
; the movie theater so that the price sensitivity of attendance
; (15 people for every 10 cents) becomes a computed constant.

(define PRICE_SENSITIVITY (/ 15 .10))
