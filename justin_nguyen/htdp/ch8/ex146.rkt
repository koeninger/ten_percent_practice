;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex146) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(check-expect
  (average (cons 1 (cons 2 (cons 3 '())))) 2)

; List-of-temperatures -> Number
; computes the average temperature 
(define (average alot)
  (/ (sum alot) (how-many alot)))

(check-expect (sum (cons 1 (cons 2 (cons 3 '())))) 6)
(check-expect (sum (cons 1 (cons 2 '()))) 3)
; List-of-temperatures -> Number 
; adds up the temperatures on the given list 
(define (sum alot)
  (cond
    [(empty? alot) 0]
    [else (+ (first alot) (sum (rest alot)))]))

(check-expect (how-many (cons 1 (cons 2 '()))) 2)
(check-expect (how-many (cons 1 '())) 1)

; List-of-temperatures -> Number 
; counts the temperatures on the given list 
(define (how-many alot)
  (cond
    [(empty? alot) 0]
    [else (+ 1 (how-many (rest alot)))]))

;(average '())
; divide by zero error

(check-expect
  (checked-average (cons 1 (cons 2 (cons 3 '())))) 2)
(check-error
  (checked-average '()))
; List-of-temperatures -> Number
; computes the average temperature, checks for empty list and errors if so
(define (checked-average alot)
  (if (equal? (how-many alot) 0)
      (error "list cannot be empty")
      (average alot)))
