;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define in ...)

(define (do-number num) (if (> num 0) (+ num 1) num)

(if (string? in) (string-length in)
    (if (image? in) (* (image-width in) (image-height in))
        (if (number? in) (do-number num)
            (if ... true or false statement ...)