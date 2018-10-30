;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex081) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct time [hours minutes seconds])
; A Time is a structure:
;   (make-time Number Number Number)
; INTERPRENTATION a time's hours, minutes, and seconds since midnight.


(define t1 (make-time 12 30 2))
(define t2 (make-time 0 0 0))
(define t3 (make-time 15 45 10))


; Time -> Number
; produces the number of seconds that have passed since midnight

(check-expect (time->seconds t1) 45002)
(check-expect (time->seconds t2) 0)
(check-expect (time->seconds t3) 56710)

(define (time->seconds t)
  (+ (time-seconds t)
     (* 60 (time-minutes t))
     (* 60 (* 60 (time-hours t)))))
