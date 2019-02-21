;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex103) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct dimensions [width depth height])

; A spider is a structure:
; legs are Numbers of legs in spider
; dim is Dimensions to hold width and height
(define-struct spiders [legs dim])

; A elefant is a structure
; dim is Dimensions to hold width and height
(define-struct elephants [dim])

; A boa is a structure:
; length is Number of length of boa
; girth is Number to hold girth of boa
(define-struct boa [length girth])

; A armadillos is a structure:
; weight is Number of lbs of armadillo
; dim is Dimensions to hold width and height
(define-struct armadillos [weight dim])


(define (fits? aml cage))