;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |110|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define CAOD_NUMBER_ER "area-of-disk: number expected")
(define CAOD_POSITIVE_ER "area-of-disk: number must be greater than zero")

; Number -> Number
; computes the area of a disk with radius r
(check-expect (area-of-disk 1) 3.14)
(check-expect (area-of-disk 42) (* 3.14 (* 42 42)))
(define (area-of-disk r)
  (* 3.14 (* r r)))


; Any -> Number
; computes the area of a disk with radius v, 
; if v is a number
(check-error (checked-area-of-disk "blah") CAOD_NUMBER_ER)
(check-error (checked-area-of-disk -1) CAOD_POSITIVE_ER)
(check-error (checked-area-of-disk 0) CAOD_POSITIVE_ER)
(check-expect (checked-area-of-disk 1) 3.14)
(check-expect (checked-area-of-disk 42) (area-of-disk 42))
(define (checked-area-of-disk v)
  (cond
    [(number? v) (cond
                   [(> v 0)(area-of-disk v)]
                   [else (error CAOD_POSITIVE_ER)])]
    [else (error CAOD_NUMBER_ER)]))
