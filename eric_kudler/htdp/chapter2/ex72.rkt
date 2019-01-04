;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex72) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct phone# [area switch num])
; A Phone# is a structure: 
;   (make-phone# Number Number Number)
; interpretation (make-phone# area switch num) means a number of 
; area the first three digits make up the area code
; switch the phone switch (exchange) of your neighborhood
; num the phone with respect to the neighborhood