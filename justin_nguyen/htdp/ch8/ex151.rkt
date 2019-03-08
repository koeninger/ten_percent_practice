;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex151) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; N N -> Number
; computes x * y

(check-expect (multiply 2 2) 4)
(check-expect (multiply 3 4) 12)
(check-expect (multiply 10 11) 110)

(define (multiply x y)
  (cond
    [(zero? x) 0]
    [else (+ y (multiply (sub1 x) y))]))