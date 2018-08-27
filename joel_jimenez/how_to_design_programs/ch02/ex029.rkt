#! /usr/local/bin/racket
#lang racket

(define BASE_ATTENDANCE 120)
(define BASE_PRICE 5.0)
(define CHANGE_PRICE (/ 15 0.1))
(define COST_PER_ATTENDEE 1.5)

(define (attendees ticket-price)
  (- BASE_ATTENDANCE (* (- ticket-price BASE_PRICE) CHANGE_PRICE)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (* COST_PER_ATTENDEE (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
  (cost ticket-price)))

(define (profit-complex price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
      (* 1.5
         (+ 120
            (* (/ 15 0.1)
               (- 5.0 price))))))

(profit 3)
(profit 4)
(profit 5)

(profit-complex 3)
(profit-complex 4)
(profit-complex 5)
