;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |111|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

(define CMV_NUMBER_ER "make-vec: number expected for both arguments")
(define CMV_POSITIVE_ER "make-vec: number for both arguments must be greater than zero")

; Any, Any -> vec
; checked-make-vec takes in two positive numbers to make a vec
;  tossing an error if the inputs deviate
(check-error (checked-make-vec "blah" 1) CMV_NUMBER_ER)
(check-error (checked-make-vec 1 "blah") CMV_NUMBER_ER)
(check-error (checked-make-vec -1 1) CMV_POSITIVE_ER)
(check-error (checked-make-vec 0 1) CMV_POSITIVE_ER)
(check-expect (checked-make-vec 1 1) (make-vec 1 1))
(check-error (checked-make-vec 1 -1) CMV_POSITIVE_ER)
(check-error (checked-make-vec 1 0) CMV_POSITIVE_ER)
(define (checked-make-vec x y)
  (cond
    [(and
      (number? x)
      (number? y))
        (cond
          [(and
            (> x 0)
            (> y 0)) (make-vec x y)]
          [else (error CMV_POSITIVE_ER)]
          )
        ]
    [else (error CMV_NUMBER_ER)]))
