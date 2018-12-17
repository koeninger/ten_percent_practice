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

; N String -> List-of-strings 
; creates a list of n copies of s
 
(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello")
              (cons "hello" (cons "hello" '())))
 
(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons s (copier (sub1 n) s))]))

(copier 3 #true)
(copier 3 (square 9 "solid" "blue"))

; N -> Number
; computes (+ n pi) without using +
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [(positive? n) (add1 (add-to-pi (sub1 n)))]))

(check-within (add 3 pi) (+ 3 pi) 0.001)
(define (add n x)
  (cond
    [(zero? n) x]
    [(positive? n) (add1 (add (sub1 n) x))]))

(check-within (multiply 3 pi) (* 3 pi) 0.001)
(define (multiply n x)
  (cond
    [(zero? n) 0]
    [(positive? n) (+ x (multiply (sub1 n) x))]))