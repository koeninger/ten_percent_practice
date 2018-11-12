;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex58) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Price falls into one of three intervals: 
; — 0 through 1000
; — 1000 through 10000
; — 10000 and above.
; interpretation the price of an item

(define LIMIT-HIGH 10000)
(define LIMIT-LOW 1000)
(define RATE-HIGH 0.08)
(define RATE-LOW 0.05)
(define RATE-NONE 0)

; Price -> Number
; computes the amount of tax charged for p
(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p 1000))
     RATE-NONE]
    [(and (<= 1000 p) (< p 10000))
     (* RATE-LOW p)]
    [(>= p 10000)
     (* RATE-HIGH p)]
    )
  )


(check-expect (sales-tax 537) RATE-NONE)
(check-expect (sales-tax 1000) (* RATE-LOW 1000))
(check-expect (sales-tax 1282) (* RATE-LOW 1282))
(check-expect (sales-tax 10000) (* RATE-HIGH 10000))
(check-expect (sales-tax 12017) (* RATE-HIGH 12017))

