;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |81|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct clock-time [hours minutes seconds])
; clock-time is (make-clock-time Number Number Number)

; clock-time -> Number
; time->seconds calculates the total number of seconds
;   that have passed since midnight
(check-expect (time->seconds (make-clock-time 12 30 2)) 45002)
(check-expect (time->seconds (make-clock-time 0 0 0)) 0)
(check-expect (time->seconds (make-clock-time 0 0 1)) 1)
(check-expect (time->seconds (make-clock-time 0 1 0)) 60)
(check-expect (time->seconds (make-clock-time 1 0 0)) 3600)
(define (time->seconds clock)
  (+
   (* (clock-time-hours clock) 3600)
   (* (clock-time-minutes clock) 60)
   (clock-time-seconds clock)))