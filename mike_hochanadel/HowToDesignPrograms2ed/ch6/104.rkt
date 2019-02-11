;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |104|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; why not just do type -> vehicle as part of the struct vs
; new structs of different vehicles that have the same
; attributes? no, there is no requirement for type handling
; the exercise uses vans, buses, etc as examples.  the
; requirement or direction is to represent vehicles.  so it
; will be just a vehicle

; A Vehicle is a structure:
;    (make-vehicle Number String Number)
; interpretation (make-vehicle capacity license mpg) specifies
; - capacity: the number of passengers
; - license: the unique license plate information
; - mpg: the number of miles per gallon
(define-struct vehicle [capacity license mpg])

; Function template
(define (some-function v)
  (cond
    [(vehicle? v) ...]
    [else ...]))