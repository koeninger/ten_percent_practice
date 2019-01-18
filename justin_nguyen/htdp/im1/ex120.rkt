;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |120|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;(x)
; illegal. there is no grammar match for (variable)

;(+ 1 (not x))
; legal. this matches the expr grammar
; (primitive expr expr) ==
; (primitive value expr) ==
; (primitive value (primitive expr)) ==
; (primitive value (primitive value))

;(+ 1 2 3)
; legal. matches the expr grammar:
; (primitive value value value)