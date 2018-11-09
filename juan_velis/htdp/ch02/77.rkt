;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |77|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct time-point [hours minutes seconds])
; (make-time-pt Number Number Number))

(define time1 (make-time-point 12 45 02))  ; 12:45:02

(define (tpoint t)
  (... (time-point-hours t)
       (time-point-minutes t)
       (time-point-seconds t)))