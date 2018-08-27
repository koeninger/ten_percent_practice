;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02_29) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 29. After studying the costs of a show,
; the owner discovered several ways of lowering the cost.
; As a result of these improvements, there is no longer a fixed cost;
; a variable cost of $1.50 per attendee remains.

; Modify both programs to reflect this change.
; When the programs are modified, test them again with ticket
; prices of $3, $4, and $5 and compare the results.


(define average_attendees 120)
(define average_price 5.0)

; (define performance_cost 180) ; No longer needed
; (define attendee_cost 0.04)
 (define attendee_cost 1.5)      ;variable cost now $1.50

(define people_coefficient 15)
(define ten_cents 0.1)

(define (attendees ticket-price)
  (- average_attendees (* (- ticket-price average_price) (/ people_coefficient ten_cents))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (* attendee_cost (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(profit 3)
(profit 4)
(profit 5)

; Now there's more profit in a $4 ticket price