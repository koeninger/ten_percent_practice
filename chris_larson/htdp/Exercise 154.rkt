;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 154|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct layer [color doll])

; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)

; RD -> String
; makes a string of colors of an-rd 
(define (colors an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else (string-append (layer-color an-rd) " " (colors (layer-doll an-rd)))]))

; RD -> String
; makes a string of colors of an-rd 
(define (inner an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else (inner (layer-doll an-rd))]))

(colors  (make-layer "yellow" (make-layer "green" "red")))
(inner  (make-layer "yellow" (make-layer "green" "red")))