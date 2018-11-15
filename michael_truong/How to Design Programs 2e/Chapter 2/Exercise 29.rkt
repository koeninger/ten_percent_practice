#lang racket

(define BASE-PRICE 5)
(define BASE-ATTENDANCE 120)
(define PRICE-SENSITIVITY 150)

(define (attendees ticket-price)
  (- BASE-ATTENDANCE (* (- ticket-price BASE-PRICE) PRICE-SENSITIVITY)))
(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define FIXED-COST 0)
(define VARIABLE-COST 1.5)

(define (cost ticket-price)
  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))