;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |27|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

(define attendance-change 15)
(define attendance 120)
(define cost-of-event 180)
(define ticket-price 5)
(define price-change 0.1)
(define var-cost-per-attendee 0.04)

(define (attendees ticket-price)
  (- 120 (* (- ticket-price ticket-price) (/ attendance-change price-change))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ cost-of-event (* var-cost-per-attendee (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

