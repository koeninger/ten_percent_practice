;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex81) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


; A Time is a structure:
;  (make-time Number Number Number)
(define-struct time [hours minutes seconds])


; Seconds is the measurement of time, represented by Number
; Time -> Seconds
; convert a given Time into Seconds
(check-expect (time->seconds (make-time 0 0 60)) 60)
(check-expect (time->seconds (make-time 0 1 5)) 65)
(check-expect (time->seconds (make-time 1 1 1)) 3661)
(check-expect (time->seconds (make-time 2 0 5)) 7205)
(define (time->seconds t)
  (+ (* (time-hours t) 3600) (* (time-minutes t) 60) (time-seconds t)))