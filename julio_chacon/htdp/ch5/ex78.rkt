;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex78) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; 3letterWords 
(define-struct 3letterWords [word])

; a Word is (make-word 1Strings 1Strings 1Strings)
(define-struct word [l1 l2 l3])

(make-3letterWords (make-word "a" "b" "c"))

