;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex63) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (distance-to-0 ap)
  (sqrt
    (+ (sqr (posn-x ap))
       (sqr (posn-y ap)))))

;(distance-to-0 (make-posn 3 4))
;(sqrt (+ (sqr 3) (sqr 4)))
;(sqrt (+ 9 (sqr 4)))
;(sqrt (+ 9 16))
;(sqrt 25)
;5

;(distance-to-0 (make-posn 6 (* 2 4)))
;(sqrt (+ (sqr 6) (sqr (* 2 4)))
;(sqrt (+ (sqr 6) (sqr 8))
;(sqrt (+ 36 (sqr 8))
;(sqrt (+ 36 64))
;(sqrt 100)
;10

;(+ (distance-to-0 (make-posn 12 5)) 10)
;(+ (sqrt (+ (sqr 12) (sqr 5))) 10)
;(+ (sqrt (+ 144 (sqr 5))) 10)
;(+ (sqrt (+ 144 25)) 10)
;(+ (sqrt 169) 10)
;(+ 13 10)
;23
