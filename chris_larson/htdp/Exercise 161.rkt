;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 161|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

(define WAGE 14)
; List-of-numbers -> List-of-numbers
; computes the weekly wages for all given weekly hours
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [(<= (first whrs) 100) (cons (wage (first whrs)) (wage* (rest whrs)))]
    [else (error "Too many hours reported")]))
 
; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* WAGE h))

(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons (* WAGE 28) '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons (* WAGE 4) (cons (* WAGE 2) '())))
(check-error (wage* (cons 101 '())) "Too many hours reported")

; List-of-numbers -> List-of-numbers
; computes the Celsius equivolent
(define (convertFC* lof)
  (cond
    [(empty? lof) '()]
    [else (cons (convertFC (first lof)) (convertFC* (rest lof)))]))

; Number -> Number
; converts Fahrenheit to Celsius
(define (convertFC f)
  (* (- f 32) 5/9))

(check-expect (convertFC* '()) '())
(check-expect (convertFC* (cons 212'())) (cons 100 '()))
(check-expect (convertFC* (cons -40 (cons 212'()))) (cons -40 (cons 100 '())))

(define EXCHANGE-RATE 2)

; List-of-numbers -> List-of-numbers
; converts dollars to euros
(define (convert-euro* lod rate)
  (cond
    [(empty? lod) '()]
    [else (cons (convert-euro (first lod) rate) (convert-euro* (rest lod) rate))]))
(check-expect (convert-euro* '() EXCHANGE-RATE) '())
(check-expect (convert-euro* (cons 1 '()) EXCHANGE-RATE) (cons (* EXCHANGE-RATE 1) '()))


; Number -> Number
; converts dollars to euros
(define (convert-euro d rate)
  (* rate d))