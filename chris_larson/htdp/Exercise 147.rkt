;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 147|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; List-of-boolean -> boolean
; determines if all the items are #true
(define (all-true lob)
  (cond
    [(empty? (rest lob)) (first lob)]
    [else (and (first lob) (all-true (rest lob)))]))
(check-expect (all-true (cons #true (cons #true (cons #true '())))) #true)
(check-expect (all-true (cons #true (cons #false (cons #true '())))) #false)

; List-of-boolean -> boolean
; determines if one item is #true
(define (one-true lob)
  (cond
   [(empty? (rest lob)) (first lob)]
   [else (or (first lob) (one-true (rest lob)))]))
(check-expect (one-true (cons #true (cons #true (cons #true '())))) #true)
(check-expect (one-true (cons #false (cons #false (cons #true '())))) #true)
(check-expect (one-true (cons #false (cons #false (cons #false '())))) #false)

; yes, accepting empty lists means we don't need checked functions
