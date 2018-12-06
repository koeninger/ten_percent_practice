;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex111) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

; Any, Any -> Number
; creates an istance of vec by calling (make-vec x y),
; if x and y are both positive numbers
(check-expect (checked-make-vec  0 1) (make-vec 0 1))
(check-error (checked-make-vec "test" 1) "make-vec positive numbers expected")
(check-error (checked-make-vec -1 1) "make-vec positive numbers expected")
(define (checked-make-vec x y)
  (cond
    [(and (number? x) (number? y) (>= x 0) (>= y 0)) (make-vec x y)]
    [else (error "make-vec positive numbers expected")]))
