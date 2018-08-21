;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ch2-2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; requires

; definitions
(define ticket-price 5)
(define COST-PER-ATTENDEE 1.5)
(define FIXED-COST 0)
(define BASE-ATTENDANCE 120)
(define BASE-TICKET-PRICE 5.0)
(define SLOPE (/ 15 0.1))
(define CURRENT-PRICE 5)
(define ALMOST-PI 3.14)
(define NL "\n")
(define MT (empty-scene 100 100))

; functions
(define (attendees ticket-price)
  (- BASE-ATTENDANCE (* (- ticket-price BASE-TICKET-PRICE) SLOPE)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST (* COST-PER-ATTENDEE (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(define (profit-v2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 0
        (* 1.5
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))

; run
(profit 1)
(profit-v2 1)
(profit 2)
(profit-v2 2)
(profit 3)
(profit-v2 3)
(profit 4)
(profit-v2 4)
(profit 5)
(profit-v2 5)

