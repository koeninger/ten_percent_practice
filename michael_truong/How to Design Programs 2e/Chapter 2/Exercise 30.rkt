#lang racket

(define BASE-ATTENDANCE 120)
(define BASE-PRICE 5)
(define P 15)
(define C .1)
(define PRICE-SENSITIVITY (/ P C))
(define FIXED-COST 180)
(define VARIABLE-COST .04)

(define (attendees ticket-price)
  (- BASE-ATTENDANCE (* (- ticket-price BASE-PRICE) PRICE-SENSITIVITY)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(define PENNY .001)
(define (optimize ticket-price upper-bound best-price max-profit)
  (cond [(<= ticket-price upper-bound) (cond
                                         [(> (profit ticket-price) max-profit) (optimize (+ ticket-price PENNY) upper-bound ticket-price (profit ticket-price))]
                                         [else (optimize (+ ticket-price PENNY) upper-bound best-price max-profit)])]
        [else best-price]))


(define LOWER-BOUND 0)
(define UPPER-BOUND 5)
(optimize LOWER-BOUND UPPER-BOUND 0 (profit 0))