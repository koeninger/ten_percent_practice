;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex072) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct entry [name phone email])
; An Entry is a structure:
;   (make-entry String String String)
; interpretation a contact's name, phone#, and email

(define-struct phone# [area switch num])
; A phone# is a structure:
;   (make-phone# Number Number Number)
; INTERPRETATION (make-phone# area switch num) means a phone# of
; area code 3 digit number from 000 to 999
; switch phone 3 digit number from 000 to 999
; num phone 4 digit number from 0000 to 9999
