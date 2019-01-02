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
(check-expect (tock (make-pair 0 '())) (make-pair 0 '()))
(check-random (tock (make-pair 1 '())) (make-pair 0 (cons (random-drop 1) '())))

; POSN
(define (random-drop w)
  (make-posn (random WIDTH) (random HEIGHT)))
(check-random (random-drop 1) (make-posn (random WIDTH) (random HEIGHT)))
              
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

; List-of-string String -> N
; determines how often s occurs in los
(define (count los s)
  (cond
    [(empty? los) 0]
    [(string=? (first los) s) (+ 1 (count (rest los) s))]
    [else (count (rest los) s)]))
(check-expect (count (cons "d" (cons "p" (cons "a" (cons "d" '())))) "d") 2)
(check-expect (count (cons "d" (cons "p" (cons "a" (cons "d" '())))) "p") 1)
(check-expect (count (cons "d" (cons "p" (cons "a" (cons "d" '())))) "f") 0)

; Son
(define es '())
 
; Number Son -> Boolean
; is x in s
(define (in? x s)
  (member? x s))

(define set123
  (cons 1 (cons 3 (cons 2 '()))))

; Number Son.L -> Son.L
; removes x from s 
(define s1.L
  (cons 1 (cons 1 '())))
 
(check-expect
  (set-.L 1 s1.L) es)
 
(define (set-.L x s)
  (remove-all x s))

(define (set+.L x s)
  (cons s x))
(check-expect (set+.L set123 4) (cons 4 set123))
(check-expect (set+.L set123 3) (cons 3 set123))

; Number Son.R -> Son.R
; removes x from s
(define s1.R
  (cons 1 '()))
 
(check-expect
  (set-.R 1 s1.R) es)
 
(define (set-.R x s)
  (remove x s))

(define (set+.R x s)
  (cond
    [(in? s x) x]
    [else (cons s x)]))
(check-expect (set+.R set123 4) (cons 4 set123))
(check-expect (set+.R set123 3) set123)
