;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 58|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; definitions
(define exempt 0)
(define normal 1000)
(define luxury 10000)

(define normalRate 0.05)
(define luxuryRate 0.08)

; A Price falls into one of three intervals: 
; — 0 through 1000
; — 1000 through 10000
; — 10000 and above.
; interpretation the price of an item

; Price -> Number
; computes the amount of tax charged for p
(define (sales-tax p)
  (cond
    [(and (<= exempt p) (< p normal)) 0]
    [(and (<= normal p) (< p luxury)) (* normalRate p)]
    [(>= p luxury) (* luxuryRate p)]))
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* normalRate 1000))
(check-expect (sales-tax 4645) (* normalRate 4645))
(check-expect (sales-tax 10000) (* luxuryRate 10000))
(check-expect (sales-tax 12017) (* luxuryRate 12017))
