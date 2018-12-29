#lang racket

(define-struct time [hours minutes seconds])

(define (minutes->seconds m)
  (* m 60))

(define (hours->minutes h)
  (* h 60))

(define (hours->seconds h)
  (minutes->seconds (hours->minutes h)))

(define (time->seconds t)
  (+ (hours->seconds (time-hours t)) (minutes->seconds (time-minutes t)) (time-seconds t)))