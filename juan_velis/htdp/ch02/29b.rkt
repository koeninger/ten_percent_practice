;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 29b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

(define attendance-change 15)
(define attendance 120)
(define cost-of-event 180)
(define price-change 0.1)
(define var-cost-per-attendee 1.50)

;(define ticket-price 3) ; 0
;(define ticket-price 4) ; 120
(define ticket-price 5) ; 240

(define (profit price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 180
        (* 1.50
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))

(profit ticket-price)