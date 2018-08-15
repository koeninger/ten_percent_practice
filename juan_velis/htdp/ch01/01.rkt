;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |01|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(+ 1 2)
(+ 1 (+ 1 (+ 1 1) 2) 3 4 5)

(+ 1 (+ 1 (+ 1 1) 2) 3 (+ 2 2) 5)
(+ 1 (+ 1 2 2) 3 4 5)
(+ 1 5 3 4 5)

(+ 3 4)
(sin 0)

;definitions
(define x 3)
(define y 4)

(+ x 10)
(sqrt (+ (* x x) (* y y)))
