;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex103) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct cage [length width height])
; A Cage is a structure: (make-cage Number Number Number).
; interpretation (make-cage x y z) is the dimensions of the cage

(define-struct spider [legs cage])
; A Spider is a structure: (make-spider Number Cage).
; interpretation (make-spider n c) n is the number of remaining legs
; and c are the dimensions of space they need in case of transport

(define-struct elephant [cage])
; An Elephant is a structure: (make-elephant Cage).
; interpretation (make-elephant c) c are the
; dimensions of space they need in case of transport

(define-struct boa [length girth])
; A Boa is a structure: (make-boa Number Number).
; interpretation (make-boa l g) l is the length of the boa
; and g is the girth of the boa

(define-struct armadillo [bands cage])
; An Armadillo is a structure: (make-armadillo Number Cage).
; interpretation (make-armadillo n c) n is the number of bands in its armor
; and c are the dimensions of space they need in case of transport

; Animal, Cage -> Boolean
; determines whether the cage’s volume is large enough for the animal
(check-expect (fits? (make-spider 8 (make-cage 2 2 1)) (make-cage 5 5 5)) #true)
(check-expect (fits? (make-elephant (make-cage 100 100 100)) (make-cage 150 150 100)) #true)
(check-expect (fits? (make-boa 48 5) (make-cage 10 8 6)) #false)
(check-expect (fits? (make-armadillo 9 (make-cage 20 15 20)) (make-cage 20 20 15)) #false)
(check-expect (fits? (make-cage 5 5 5) (make-cage 5 5 5)) #false)
(define (fits? animal cage)
  (cond
    [(spider? animal)(and
       (<= (cage-length(spider-cage animal)) (cage-length cage))
       (<= (cage-width(spider-cage animal)) (cage-width cage))
       (<= (cage-height(spider-cage animal)) (cage-height cage)))]
    [(elephant? animal)(and
       (<= (cage-length(elephant-cage animal)) (cage-length cage))
       (<= (cage-width(elephant-cage animal)) (cage-width cage))
       (<= (cage-height(elephant-cage animal)) (cage-height cage)))]
    [(boa? animal)(<=
       (/ (* (sqr (boa-length animal)) (boa-girth animal)) (* 4 pi))
       (* (cage-length cage) (cage-width cage) (cage-height cage)))]
    [(armadillo? animal)(and
       (<= (cage-length(armadillo-cage animal)) (cage-length cage))
       (<= (cage-width(armadillo-cage animal)) (cage-width cage))
       (<= (cage-height(armadillo-cage animal)) (cage-height cage)))]
    [else #false]))