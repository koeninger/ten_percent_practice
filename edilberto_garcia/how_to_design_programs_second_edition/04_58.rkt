;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_58) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 58. Introduce constant definitions that separate the intervals for low prices and
;    luxury prices from the others so that the legislators in Tax Land can easily raise the
;    taxes even more.


; A Price falls into one of three intervals: 
; — 0 through 1000
; — 1000 through 10000
; — 10000 and above.
; interpretation the price of an item


(define LOW_TAX 0.05)
(define LUXURY_TAX .08)

(define LOW_PRICE_FLOOR 1000)
(define LOW_PRICE_CEILING 10000)


; Price -> Number
; computes the amount of tax charged for p
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* LOW_TAX 1000))
(check-expect (sales-tax 12017) (* LUXURY_TAX 12017))
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 1282) (* LOW_TAX 1282))
(check-expect (sales-tax 10000) (* LOW_TAX 10000))
(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p LOW_PRICE_FLOOR)) 0]
    [(and (<= LOW_PRICE_FLOOR p) (<= p LOW_PRICE_CEILING)) (* LOW_TAX p)]
    [(> p LOW_PRICE_CEILING) (* LUXURY_TAX p)] )
 
 )