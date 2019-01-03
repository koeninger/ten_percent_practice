;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 159|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define ROWS 8)
(define COLS 18)
(define SPACING 20)
(define WIDTH (* SPACING COLS))
(define HEIGHT (* SPACING ROWS))

(define-struct pair [balloon# lob])
; A Pair is a structure (make-pair N List-of-posns)
; A List-of-posns is one of: 
; – '()
; – (cons Posn List-of-posns)
; interpretation (make-pair n lob) means n balloons 
; must yet be thrown and added to lob

; NaturalNumber Image -> Image
; produces a columns of horizontal arragnement of n copies of the image
(define (row n img)
  (cond
    [(zero? n) (square 1 "solid" "white")]
    [(positive? n) (above/align "left" img (row (sub1 n) img))]))


; NaturalNumber Image -> Image
; produces a columns of vertical arragnement of n copies of the image
(define (col n img)
  (cond
    [(zero? n) (square 1 "solid" "white")]
    [(positive? n) (beside/align "top" img (col (sub1 n) img))]))

(define GRID (place-image (row ROWS (col COLS (square SPACING "outline" "black"))) (/ WIDTH 2) (/ HEIGHT 2) (empty-scene WIDTH HEIGHT)))

; List-of-posn image -> image
; places red dots at the list of posn
(define (add-balloons lop img)
  (cond
    [(empty? lop) img]
    [else (place-image (circle 5 "solid" "red") (posn-x (first lop)) (posn-y (first lop)) (add-balloons (rest lop) img))]))

;
(define (tock w)
  (cond
    [(> (pair-balloon# w) 0) (make-pair (sub1 (pair-balloon# w)) (cons (random-drop (pair-balloon# w)) (pair-lob w)))]
    [else w]))

; POSN
(define (random-drop w)
  (make-posn (random WIDTH) (random HEIGHT)))

; Number -> Image
(define (riot pair)
  ...)

; draws balloons on grid
(define (to-image pair)
  (add-balloons (pair-lob pair) GRID))

; BaloonRiot -> BaloonRiot 
(define (main w0)
  (big-bang w0
    [on-tick tock 1]
    [to-draw to-image]))