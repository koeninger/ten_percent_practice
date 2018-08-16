;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex11) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (distance x y) (sqrt (+ (expt x 2) (expt y 2))))

(distance 1 1)
(distance 0 2)
(distance 2 0)
(distance 10 15)