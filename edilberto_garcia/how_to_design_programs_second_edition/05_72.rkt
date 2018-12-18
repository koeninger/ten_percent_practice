;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_72) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 72. Formulate a data definition for the above phone structure type definition that accommodates the given examples.



; Next formulate a data definition for phone numbers using this structure type definition:
(define-struct phone# [area switch num])

; An Phone# is a structure: 
;   (make-phone# String String String)
; interpretation a phone number's area code, switch number, and house number 


;Historically, the first three digits make up the area code, the next three the code for the phone switch (exchange) of your neighborhood, and the last four the phone with respect to the neighborhood. Describe the content of the three fields as precisely as possible with intervals.

; An area code number falls under one interval
; [001, 999]

; A switch number falls under one interval
; [001, 999]

; A house number falls under one interval
; [0000, 9999]