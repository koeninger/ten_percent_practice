;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex72) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct phone# [area switch num])
; An phone# is a structure: 
;   (make-phone# Number Number Number)
; interpretation (make-phone area switch num) means
; area is a 3 digit number with intervals of [100 - 999]
; switch is a 3 digit number with interval of [000 - 999]
; num is a 4 digit number with interval [0000 - 9999]