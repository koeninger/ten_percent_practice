;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex72) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct phone [area number])
; (make-phone Number Number)
; interpretation area number and phone number


(define-struct phone# [area switch num])
; (make-phone Number Number Number)
; interpretation area number, switch number, phone number
; these numbers are 3 digit numbers that fall between 000 and 999