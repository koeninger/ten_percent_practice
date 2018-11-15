;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex58) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 1282) (* 0.05 1282))
(check-expect (sales-tax 10000) (* 0.08 10000))
(check-expect (sales-tax 12017) (* 0.08 12017))


(define INEXPENSIVE-MAX 1000) 
(define LUXURY-MAX 10000)
(define INEXPENSIVE-RATE 0.05)
(define LUXURY-RATE 0.08)

(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p INEXPENSIVE-MAX)) 0]
    [(and (<= INEXPENSIVE-MAX p) (< p LUXURY-MAX)) (* INEXPENSIVE-RATE p)]
    [(>= p LUXURY-MAX) (* LUXURY-RATE p)]))