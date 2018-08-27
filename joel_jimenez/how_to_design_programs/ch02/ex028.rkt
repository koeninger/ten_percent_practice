#! /usr/local/bin/racket
#lang racket

(define BASE_ATTENDANCE 120)
(define BASE_PRICE 5.0)
(define CHANGE_PRICE (/ 15 0.1))
(define FIXED_COST 180)
(define COST_PER_ATTENDEE 0.04)

(define (attendees ticket-price)
  (- BASE_ATTENDANCE (* (- ticket-price BASE_PRICE) CHANGE_PRICE)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED_COST (* COST_PER_ATTENDEE (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
  (cost ticket-price)))

(define (profit_complex price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 180
        (* 0.04
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))

(profit 1)
(profit 2)
(profit 3)
(profit 4)
(profit 5)
(profit 2.90) ;best ticket price to a dime

(profit_complex 1)
(profit_complex 2)
(profit_complex 3)
(profit_complex 4)
(profit_complex 5)
