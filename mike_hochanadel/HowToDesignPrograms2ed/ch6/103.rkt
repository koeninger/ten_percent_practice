;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |103|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; An Animal has a body and other attributes

; A Spider has a body and up to 8 remaining circular legs

; An Elephant has a body

; A Boa Constrictor has a circular body

; An Armadillo has a body and a circular tail

; A Cage is a structure:
; (make-cage Number Number Number).
; Where the Numbers are length, width, and height respectively

; Animal, Cage -> boolean
; fits? checks to see if the Animal can fit in the Cage