;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ch2-2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; requires

; definitions
(define ticket-price 5)
(define cost-per-attendee 0.04)
(define fixed-cost 180)
(define base-attendance 120)
(define base-ticket-price 5.0)
(define slope (/ 15 0.1))

; functions
(define (attendees ticket-price)
  (- base-attendance (* (- ticket-price base-ticket-price) slope)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ fixed-cost (* cost-per-attendee (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(define (profit-v2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 180
        (* 0.04
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
(profit 2.9)

