;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |120|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; ex 120

; (x)
; illegal - (variable expr expr ...)

; (+ 1 (not x))
; illegal. 'not' is a boolean operator, while plus is a num primitive

; (+ 1 2 3)
; legal - expression