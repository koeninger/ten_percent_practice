;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex77) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; a Time are points in time since midnight
(define-struct time [timePoint])

; a Points is (make-points Number Number Number)
(define-struct points [hours minutes seconds])

(make-time (make-points 11 20 39))

