;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 142|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; List-of-string -> String
; concatenates all strings in l into one long string
 
(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect
  (cat (cons "ab" (cons "cd" (cons "ef" '()))))
  "abcdef")
 
(define (cat l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l) (cat (rest l)))]))

; ImageOrFalse is one of:
; – Image
; – #false

; List-of-images PositiveNumber -> ImageOrFalse
; returns the first image that is not a square n x n
(define (ill-sized? loi n)
  (cond
    [(empty? loi) #false]
    [(and (equal? n (image-width (first loi))) (equal? n (image-height (first loi)))) (ill-sized? (rest loi) n)]
    [else (first loi)]))
(check-expect (ill-sized? (cons (square 40 "solid" "slateblue") (cons (square 40 "solid" "slateblue") (cons (square 40 "solid" "slateblue") '()))) 40) #false)
(check-expect (ill-sized? (cons (square 50 "solid" "slateblue") (cons (square 40 "solid" "slateblue") (cons (square 40 "solid" "slateblue") '()))) 40) (square 50 "solid" "slateblue"))
(check-expect (ill-sized? (cons (square 40 "solid" "slateblue") (cons (square 40 "solid" "slateblue") (cons (square 40 "solid" "slateblue") '()))) 50) (square 40 "solid" "slateblue"))

; List-of-temperatures -> Number
; computes the average temperature 
(define (average alot)
  (/ (sum alot) (how-many alot)))
 
; List-of-temperatures -> Number 
; counts the temperatures on the given list 
(define (how-many alos)
  (cond
    [(empty? alos) 0]
    [else (+ (how-many (rest alos)) 1)]))
(check-expect (how-many '()) 0)
(check-expect (how-many (cons "a" '())) 1)
(check-expect
  (how-many (cons "b" (cons "a" '()))) 2)

; List-of-temperatures -> Number 
; adds up the temperatures on the given list 
(define (sum alot)
  (cond
    [(empty? alot) 0]
    [else (+ (first alot) (sum (rest alot)))]))

; List-of-temperatures -> Number
; checks List-of-temperatures
(define (checked-average alot)
  (cond
    [(empty? alot) (error "Nothing to average")]
    [else (average alot)]))

; NEList-of-temperatures is a subset of List-of-temperatures so the function will work
(check-expect (sum (cons 1 (cons 2 (cons 3 '())))) 6)

; NEList-of-temperatures -> boolean
; determins if the list is sorted
(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) #true]
    [else (and (> (first ne-l) (first (rest ne-l))) (sorted>? (rest ne-l)))]))
(check-expect (sorted>? (cons 10 (cons 9 (cons 8 '())))) #true)
(check-expect (sorted>? (cons 8 (cons 9 (cons 10 '())))) #false)