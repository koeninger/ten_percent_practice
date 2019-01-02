;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex81) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Time is a structure:
;  (make-time Number Number Number)
(define-struct time [hours minutes seconds])

; Seconds is the measurement of time, represented by Number
; Time -> Seconds
; convert a given Time into Seconds
(check-expect (time->seconds (make-time 0 0 42)) 42)
(check-expect (time->seconds (make-time 0 1 30)) 90)
(check-expect (time->seconds (make-time 1 2 7)) 3727)
(check-expect (time->seconds (make-time 4 6 17)) 14777)
(define (time->seconds t)
  (+ (* (time-hours t) 3600) (* (time-minutes t) 60) (time-seconds t)))