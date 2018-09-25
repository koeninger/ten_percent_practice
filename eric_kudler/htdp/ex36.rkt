;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex36) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; We use a variable that can represent image data.
; Image -> Number
; Return the length of an image multiplied by width.
; given: (empty scene 20 20), expect: 400
; given: (empty scene 30 30), expect: 900
(require 2htdp/image)
(define (image-area image)
  (* (image-width image) (image-height image)))

(image-area (empty-scene 20 20))