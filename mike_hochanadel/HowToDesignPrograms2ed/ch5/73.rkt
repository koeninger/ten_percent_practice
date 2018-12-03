;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |73|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Posn -> Posn
; Updates the X coordinate of a given Posn with the Number n
(check-expect (posn-up-x (make-posn 10 0) 3) (make-posn 3 0))
(check-expect (posn-up-x (make-posn 10 0) 0) (make-posn 0 0))
(check-expect (posn-up-x (make-posn 10 0) 10) (make-posn 10 0))
(check-expect (posn-up-x (make-posn 10 0) -1) (make-posn -1 0))
(define (posn-up-x p n)
  (make-posn n (posn-y p)))