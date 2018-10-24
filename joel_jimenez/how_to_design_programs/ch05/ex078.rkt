;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex078) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct word [letter1 letter2 letter3])
; A Word is a structure:
;   (make-time 1Strings|#false 1Strings|#false 1Strings|#false)
; INTERPRENTATION a three-letter word where each character has a value of 1Strings or #false
