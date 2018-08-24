;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 02_27) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define average_attendees 120)
(define average_price 5.0)

(define performance_cost 180)
(define attendee_cost 0.04)

(define people_coefficient 15)
(define ten_cents 0.1)

(define (attendees ticket-price)
  (- average_attendees (* (- ticket-price average_price) (/ people_coefficient ten_cents))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ performance_cost (* attendee_cost (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

; Exercise 27. Our solution to the sample problem contains several constants in the middle of functions.
; As One Program, Many Definitions already points out,
; it is best to give names to such constants so that future readers understand where these numbers come from.
; Collect all definitions in DrRacket’s definitions area and change them so that all magic numbers are refactored into constant definitions.