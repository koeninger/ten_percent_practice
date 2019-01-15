;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 176|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Matrix is one of: 
;  – (cons Row '())
;  – (cons Row Matrix)
; constraint all rows in matrix are of the same length
 
; A Row is one of: 
;  – '() 
;  – (cons Number Row)

(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define mat1 (cons row1 (cons row2 '())))

(define row1i (cons 11 (cons 21 '())))
(define row2i (cons 12 (cons 22 '())))
(define mat1i (cons row1i (cons row2i '())))

; Matrix -> Matrix
; transposes the given matrix along the diagonal 
 
(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))
(define tam1 (cons wor1 (cons wor2 '())))
 
(check-expect (transpose mat1) tam1)
 
(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
    [else (cons (first* lln) (transpose (rest* lln)))]))
(check-expect (transpose mat1) mat1i)

; List-of-lines -> List-of-numbers
; returns the first column of a matrix
(define (first* lln)
  (cond
    [(empty? lln) '()]
    [else (cons (first (first lln)) (first* (rest lln)))]))
(check-expect (first* mat1) (cons 11 (cons 21 '())))

; List-of-lines -> List-of-lines
; returns a matrix with first column removed
(define (rest* lln)
  (cond
    [(empty? lln) '()]
    [else (cons (rest (first lln)) (rest* (rest lln)))]))
(check-expect (rest* mat1) (cons (cons 12 '()) (cons (cons 22 '()) '())))
