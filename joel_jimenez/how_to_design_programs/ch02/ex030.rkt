#! /usr/local/bin/racket
#lang racket

(define BASE-ATTENDANCE 120)
(define BASE-PRICE 5.0)
(define CHANGE-OF-ATTENDANCE 15)
(define CHANGE-OF-PRICE 0.1)
(define PRICE-SENSITIVITY (/ CHANGE-OF-ATTENDANCE CHANGE-OF-PRICE))
(define COST-PER-ATTENDEE 1.5)

(define (attendees ticket-price)
  (- BASE-ATTENDANCE (* (- ticket-price BASE-PRICE) PRICE-SENSITIVITY)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (* COST-PER-ATTENDEE (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
  (cost ticket-price)))

(profit 3)
(profit 4)
(profit 5)
