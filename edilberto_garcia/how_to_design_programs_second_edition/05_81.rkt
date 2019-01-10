;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_81) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 81. Design the function time->seconds, which consumes instances of time structures
;    (see exercise 77) and produces the number of seconds that have passed since midnight.
;    For example, if you are representing 12 hours, 30 minutes, and 2 seconds with one of
;    these structures and if you then apply time->seconds to this instance, the correct result is 45002.



(define HOURS_MULTIPLIER 3600)
(define MINUTES_MULTIPLIER 60)
(define SECONDS_MULTIPLIER 1)

(define-struct time [hours minutes seconds])

(check-expect (time->seconds (make-time 12 0 0)) (* HOURS_MULTIPLIER 12))
(check-expect (time->seconds (make-time  0 0 3)) 3)
(define (time->seconds timeStruc)
  (+
     (* (time-hours timeStruc) HOURS_MULTIPLIER)
     (* (time-minutes timeStruc) MINUTES_MULTIPLIER)
     (time-seconds timeStruc)
  )
)
    
