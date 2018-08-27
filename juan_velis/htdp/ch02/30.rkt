;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |30|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define ATTENDANCE-CHANGE 15)
(define ATTENDANCE 120)
(define COST-OF-EVENT 180)
(define PRICE-CHANGE 0.1)
(define TICKET 5)
(define VAR-COST (* ATTENDANCE-CHANGE PRICE-CHANGE))

(define (attendees ticket-price)
  (- ATTENDANCE (* (- ticket-price ticket-price) (/ ATTENDANCE-CHANGE PRICE-CHANGE))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ COST-OF-EVENT (* VAR-COST (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(profit TICKET)