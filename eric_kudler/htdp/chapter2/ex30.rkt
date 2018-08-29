;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex30) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define DEFAULT_AUDIENCE 120)
(define DEFAULT_PRICE 5.0)
(define ATTENDANCE_CHANGE 15)
(define PRICE_SENSITIVITY (/ ATTENDANCE_CHANGE PRICE_CHANGE))
(define PRICE_CHANGE .1)
(define fixed_price 0)
(define price_per_consumer 1.5)

(define (attendees ticket-price)
  (- DEFAULT_AUDIENCE (* (- ticket-price DEFAULT_PRICE) (/ ATTENDANCE_CHANGE PRICE_CHANGE))))
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
