;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex111) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector
(define-struct vec [x y])



(check-expect (make-check-vec 1 3) (make-vec 1 3))
(check-expect (make-check-vec 5 10) (make-vec 5 10))
(define (make-check-vec x y)
  (cond
    [(and (number? x) (number? y))
     (cond
       [(and (positive? x) (positive? y))
        (make-vec x y)]
       [else (error "make-vec: x and y must be positive")])]
    [else (error "make-vec: x and y must be numbers")]))