;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |63|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
#|
(distance-to-0 (make-posn 3 4))
3*3 = 9
4*4 = 16
9+15 = 25
sqrt(25) = 5

(distance-to-0 (make-posn 6 (* 2 4)))
2*4 = 8
6*6 = 36
8*8 = 64
36+64 = 100
sqrt(100) = 10

(+ (distance-to-0 (make-posn 12 5)) 10)
12*12 = 144
5*5 = 25
144+25 = 169
sqrt(169) = 13
13+10 = 23
|#

; computes the distance of ap to the origin 
(check-expect (distance-to-0 (make-posn 0 5)) 5)
(check-expect (distance-to-0 (make-posn 7 0)) 7)
(check-expect (distance-to-0 (make-posn 3 4)) 5)
(check-expect (distance-to-0 (make-posn 8 6)) 10)
(check-expect (distance-to-0 (make-posn 5 12)) 13)
(define (distance-to-0 ap)
  (sqrt
    (+ (sqr (posn-x ap))
       (sqr (posn-y ap)))))

(distance-to-0 (make-posn 3 4))

(distance-to-0 (make-posn 6 (* 2 4)))

(+ (distance-to-0 (make-posn 12 5)) 10)

