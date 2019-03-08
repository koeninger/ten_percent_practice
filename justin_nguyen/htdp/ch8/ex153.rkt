;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex153) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define CIRCLE (circle 3 "solid" "red"))
(define SQUARE (square 10 "outline" "black"))

(define SCENE-WIDTH 80)
(define SCENE-HEIGHT 180)

(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))

(check-expect (col 2 CIRCLE) (above CIRCLE CIRCLE empty-image))
(check-expect (col 1 CIRCLE) (above CIRCLE empty-image))

; N Image -> Image
; produces column of n copies of image
(define (col x i)
  (cond
    [(zero? x) empty-image]
    [else (above i (col (sub1 x) i))]))


(check-expect (row 2 CIRCLE) (beside CIRCLE CIRCLE empty-image))
(check-expect (row 1 CIRCLE) (beside CIRCLE empty-image))
; N Image -> Image
; produces row of n copies of image
(define (row x i)
  (cond
    [(zero? x) empty-image]
    [else (beside i (row (sub1 x) i))]))

(define LECTURE-HALL (place-image (col SCENE-HEIGHT (row SCENE-WIDTH SQUARE))
                                  0
                                  0
                                  SCENE))

; List-of-Posns -> Image
; produces image with balloons at specified posns
; given posns will be within space of the lecture hall
(define (add-balloons l)
  (cond
    ((empty? l) LECTURE-HALL)
    (else (place-image CIRCLE
                       (posn-x (first l))
                       (posn-y (first l))
                       (add-balloons (rest l))))))

(add-balloons (cons (make-posn 10 10) (cons (make-posn 20 35) '())))

; (make-posn 80 180) -- last balloon