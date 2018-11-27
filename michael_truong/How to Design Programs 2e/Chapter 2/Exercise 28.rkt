#lang racket

(define BASE-PRICE 5)
(define BASE-ATTENDANCE 120)
(define PRICE-SENSITIVITY 150)
(define (attendees ticket-price)
  (- BASE-ATTENDANCE (* (- ticket-price BASE-PRICE) PRICE-SENSITIVITY)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define FIXED-COST 180)
(define VARIABLE-COST .04)
(define (cost ticket-price)
  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(define PENNY .1)
(define UPPER-BOUND 5)
(define (optimize ticket-price best-price max-profit)
  (cond [(<= ticket-price UPPER-BOUND) (cond
                                         [(> (profit ticket-price) max-profit) (optimize (+ ticket-price PENNY) ticket-price (profit ticket-price))]
                                         [else (optimize (+ ticket-price PENNY) best-price max-profit)])]
        [else best-price]))

(optimize 0 0 (profit 0))