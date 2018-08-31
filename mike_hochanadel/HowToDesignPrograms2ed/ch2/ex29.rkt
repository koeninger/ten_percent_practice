;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex29) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define AVERAGE_ATTENDANCE 120)
(define AVERAGE_TICKET_PRICE 5.0)
(define PRICE_CHANGE_DIVISOR 0.1)
(define ATTENDANCE_PER_PRICE_CHANGE 15)
(define FIXED_COST 180)
(define COST_PER_ATTENDEE 0.04)

(define (attendees ticket-price)
  (- AVERAGE_ATTENDANCE
     (* (- ticket-price AVERAGE_TICKET_PRICE) (/ ATTENDANCE_PER_PRICE_CHANGE PRICE_CHANGE_DIVISOR))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (* COST_PER_ATTENDEE (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(define (profit2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
             (* 0.04
           (+ 120
            (* (/ 15 0.1)
               (- 5.0 price))))))