;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;(define in (rectangle 5 10 "solid" "green"))
;(define in "four")
;(define in 0)
;(define in 5)
;(define in #true)
(define in #false)



(define (do-number num) (if (> num 0) (- num 1) num))
(define (do-bool bool) (if bool 10 20))

(if (string? in) (string-length in)
    (if (image? in) (* (image-width in) (image-height in))
        (if (number? in) (do-number in)
            (if (boolean? in) (do-bool in) "bad input"))))