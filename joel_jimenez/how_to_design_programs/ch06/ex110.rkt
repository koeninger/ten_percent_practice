;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex110) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Any BSL value is one of:
; – Number
; – Boolean
; – String
; – Image
; – (make-posn Any Any)
; ...
; – (make-tank Any Any)
; ...

; Number -> Number
; computes the area of a disk with radius r
(define (area-of-disk r)
  (* 3.14 (* r r)))

; Any -> Number
; computes the area of a disk with radius v,
; if v is a positive number
(check-expect (checked-area-of-disk 1) (area-of-disk 1))
(check-error (checked-area-of-disk -1) "area-of-disk: positive number expected")
(check-error (checked-area-of-disk "test") "area-of-disk: positive number expected")
(define (checked-area-of-disk v)
  (cond
    [(and (number? v) (>= v 0)) (area-of-disk v)]
    [else (error "area-of-disk: positive number expected")]))
