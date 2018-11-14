;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |81|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct time-point [hours minutes seconds])
; (make-time-pt Number Number Number))

(define midnight (make-time-point 00 00 00))  ; midnight
(define time (make-time-point 12 30 02))  ; 

(check-expect (time->seconds midnight) 0)
(check-expect (time->seconds time) 45002)

(define (time->seconds t)
  (+ (* (time-point-hours t) 3600)
       (* (time-point-minutes t) 60)
       (time-point-seconds t))
  )

(time->seconds time)
