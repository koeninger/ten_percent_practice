;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |72|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct phone# [area switch num])
; A Phone Number is a structure: 
;   (make-phone# Number Number Number)
; interpretation (make-phone# area switch num) means a phone number of
; area code made of 3 digits [000, 999]
; phone switch (exchange) made of 3 digits [000, 999]
; phone number made of 4 digits [0000, 9999]
