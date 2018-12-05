#lang racket

(require test-engine/racket-tests)

(define TAX-BRACKET-1 1000)
(define TAX-BRACKET-2 10000)

(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 12017) (* 0.08 12017))
(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p TAX-BRACKET-1)) 0]
    [(and (<= TAX-BRACKET-1 p) (< p TAX-BRACKET-2)) (* 0.05 p)]
    [(>= p TAX-BRACKET-2) (* 0.08 p)]))