;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex58) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define INEXEPENSIVE_LOWER_BOUND 0)
(define INEXEPENSIVE_UPPER_BOUND 1000)

(define INBETWEEN_LOWER_BOUND 1000)
(define INBETWEEN_UPPER_BOUND 10000)

(define LUXURY_LOWER_BOUND 10000)


(define (sales-tax p)
  (cond
    [(and (<= INEXEPENSIVE_LOWER_BOUND p) (< p INEXEPENSIVE_UPPER_BOUND)) 0]
    [(and (<= INBETWEEN_LOWER_BOUND p) (< p INBETWEEN_UPPER_BOUND)) (* 0.05 p)]
    [(>= p LUXURY_LOWER_BOUND) (* 0.08 p)]))