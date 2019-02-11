;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex138) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)


; '()
; (cons 1 '())
; 1
; (cons 1 (cons 2 '()))
; 3
;
(define (sum l)
  (cond
    [(empty? l) 0]
    [(cons? l)
     (+ (first l) (sum (rest l)))]))

(check-expect (sum (cons 1 '()))
              1)
(check-expect (sum (cons 1 (cons 2 '())))
              3)