;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(define in 20)
(define in (if (string? in) (string-length in) in))
(define in ((if (number? in) (if (> in 0) in (- in 1)) in)))
(define in ((if (image? in) (* (image-width in) (image-height in)) in)))
(define in ((if (boolean? in) (if #true 20 10) in)))