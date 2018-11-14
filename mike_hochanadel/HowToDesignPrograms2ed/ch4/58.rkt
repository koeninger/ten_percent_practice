;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |58|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Price falls into one of three intervals: 
; — 0 through 1000
; — 1000 through 10000
; — 10000 and above.
; interpretation the price of an item

(define LOW_BOUNDARY 1000)
(define HIGH_BOUNDARY 10000)
(define LOW_TAX_RATE 0)
(define MEDIUM_TAX_RATE 0.05)
(define HIGH_TAX_RATE 0.08)

; Price -> Number
; computes the amount of tax charged for p
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 10000) (* HIGH_TAX_RATE 10000))
(check-expect (sales-tax 1000) (* MEDIUM_TAX_RATE 1000))
(check-expect (sales-tax 12017) (* HIGH_TAX_RATE 12017))
(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p LOW_BOUNDARY)) (* p LOW_TAX_RATE)]
    [(and (<= LOW_BOUNDARY p) (< p HIGH_BOUNDARY)) (* MEDIUM_TAX_RATE p)]
    [(>= p HIGH_BOUNDARY) (* HIGH_TAX_RATE p)]))