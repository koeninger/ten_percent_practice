;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex30) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define BASE-ATTENDANCE 120)
(define BASE-TICKET-PRICE 5)
(define AVG-ATTENDANCE-VARIATION 15.0)
(define AVG-PRICE-VARIATION 0.1)
(define PRICE-SENSITIVITY
(define FIXED-COST 0)
(define COST-PER-ATTENDEE 1.5)


(define (attendees ticket-price)
  (- BASE-ATTENDANCE (* (- ticket-price BASE-TICKET-PRICE) (/ AVG-ATTENDANCE-VARIATION AVG-PRICE-VARIATION))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST (* COST-PER-ATTENDEE (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(profit 3)
(profit 4)
(profit 5)
