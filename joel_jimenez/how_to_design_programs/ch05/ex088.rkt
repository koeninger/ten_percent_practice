;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex088) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct VCat [x-coordinate happiness])
; A VCat is a structure:
;   (make-VCat Number Number)
; interpretation (make-VCat x h) describes a cat whose
; x-coordinate is x and h is its happiness level (0-100)