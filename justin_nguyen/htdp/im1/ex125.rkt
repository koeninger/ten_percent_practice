;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex125) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;(define-struct oops [])
; legal. matches the struture grammar: (define-struct name [name ...])

;(define-struct child [parents dob date])
; legal. matches the struture grammar: (define-struct name [name ...])

;(define-struct (child person) [dob date])
; illegal. (child person) is not a name.

