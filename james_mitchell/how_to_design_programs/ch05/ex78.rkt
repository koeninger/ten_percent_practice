;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex78) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; letter is one of
; 1String [a,z]
; #false
; lower case letters [a,z] or no letter or
; 1string or !1string

(define letter1 "a")
(define letter2 "k")
(define letter3 #false)

; a word is 3 letters
; word is a (make-word letter letter letter)
(define-struct word [lt1 lt2 lt3])
