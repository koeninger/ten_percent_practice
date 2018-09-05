;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex36) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
; Number represents number of pixels
; Image -> Number
; calcukate number of pixels in image
; given (rectangle 10 10 "solid" "green"), expect 100
; given (rectangle 5 6 "solid" "blue"), expect 30

(define (image-area img)
  (* (image-height img) (image-width img)))

(image-area (rectangle 10 10 "solid" "green"))
(image-area (rectangle 5 6 "solid" "blue"))