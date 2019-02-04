;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |111|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct vec [x y])
; A vec is (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

; Any Any -> Vec
(define (checked-make-vec n1 n2)
  (cond [(and (number? n1) (>= n1 0))
         (cond [(and (number? n2) (>= n2 0)) (make-vec n1 n2)]
               [else (error "parameter 2 must be a positve number")])
        ]
        [else (error "parameter 1 must be a positive number")]
  )
)
