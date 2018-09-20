;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex30) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define attendance-ratio 15)
(define price-per-15 .10)
(define suggested-price 5.0)
(define attendance 120)
(define performance-cost 180)
(define variable-cost 1.50)
(define PRICE-ATTENDANCE (/ attendance-ratio price-per-15))


(define (attendees ticket-price)
  (- attendance (* (- ticket-price suggested-price)  PRICE-ATTENDANCE)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))


(define (cost ticket-price)
  (* variable-cost (attendees ticket-price)))


(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))


(define (profit2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     
        (* 1.50
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price))))))



(profit 3.0)
(profit 4.0)
(profit 5.0)

(profit2 3.0)
(profit2 4.0)
(profit2 5.0)
