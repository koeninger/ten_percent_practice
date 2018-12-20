;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex81) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; a Time are points in time since midnight
(define-struct time [hours minutes seconds])

; Time -> Seconds
; time is a point in time and returns seconds that have passed since midnight
(check-expect (timeInsecods (make-time 12 30 2)) 45002)  
(define (timeInsecods t)
  (+ (* (* (time-hours t) 60) 60) (* (time-minutes t) 60) (time-seconds t) ))


