;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex29) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define default_audience 120)
(define default_price 5.0)
(define attendance_change 15)
(define price_change .1)
(define fixed_price 0)
(define price_per_consumer 1.5)

(define (attendees ticket-price)
  (- default_audience (* (- ticket-price default_price) (/ attendance_change price_change))))
(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))
(define (cost ticket-price)
  (+ fixed_price (* price_per_consumer (attendees ticket-price))))
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(profit 3)
;630
(profit 4)
;675
(profit 5)
;420
