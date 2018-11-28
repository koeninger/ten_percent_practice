;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_63) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(make-posn 3 4); computes the distance of ap to the origin


(check-expect (distance-to-0 (make-posn 0 5)) 5)
(check-expect (distance-to-0 (make-posn 7 0)) 7)
(check-expect (distance-to-0 (make-posn 3 4)) 5)
(check-expect (distance-to-0 (make-posn 8 6)) 10)
(check-expect (distance-to-0 (make-posn 5 12)) 13)

(define (distance-to-0 ap)
  (sqrt
     (+ (sqr (posn-x ap))
       (sqr (posn-y ap))))
)

; Exercise 63. Evaluate the following expressions:
(distance-to-0 (make-posn 3 4))

(distance-to-0 (make-posn 6 (* 2 4)))

(+ (distance-to-0 (make-posn 12 5)) 10)



; by hand. Show all steps. Assume that sqr performs its computation in a single step. Check the results with DrRacket’s stepper.

; 9 + 16 = 25, sqrt(25) = 5
; 36 + (2*4), 36 + 64 = 100, sqrt(100) = 10
;  12 * 12 + 5 * 5, 144 + 25 = 169, sqrt(169) + 10, 13+10 = 23