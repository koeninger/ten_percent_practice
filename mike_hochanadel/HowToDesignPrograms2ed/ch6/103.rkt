;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |103|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct body [x y z])
; A Body is a structure
;   (make-body Number Number Number),
; interpretation (make-body x y z) specifies the relative
; space it fills

(define-struct circular-body [x radius])
; A Circular Body is a structure
;   (make-circular-body Number Number),
; interpretation (make-circular-body x radius) specifies the
; relative space it fills where x is the length and
; the radius is the length from the center of the body
; the circumference of the body

; A Zoo Animal has is one of:
; - Body
; - Circular Body
; - 1 or more Bodies and 1 or more Circular Bodies
; interpretation 

; A Spider is a structure has a body
;   and up to 8 remaining circular body parts called legs


; An Elephant has a body
;  interpretation represents a body

; A Boa Constrictor has a circular body
;  interpretation represents a circular body

; An Armadillo has a body and a circular body called a tail
;  interpretation 

; A Cage is a structure:
; (make-cage Number Number Number).
; Where the Numbers are length, width, and height respectively

; Animal, Cage -> boolean
; fits? checks to see if the Animal can fit in the Cage