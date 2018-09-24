;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex27) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define attendance-ratio 15)
(define price-per-15 .10)
(define suggested-price 5.0)
(define attendance 120)
(define performance-cost 180)
(define variable-cost 0.04)


(define (attendees ticket-price)
  (- attendance (* (- ticket-price suggested-price) (/ attendance-ratio price-per-15))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))


(define (cost ticket-price)
  (+ performance-cost (* variable-cost (attendees ticket-price))))


(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

