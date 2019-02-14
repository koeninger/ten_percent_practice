;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex139) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)


; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)

(check-expect (pos? '()) #true)
(check-expect (pos? (cons 1 '())) #true)
(check-expect (pos? (cons 1 (cons 2 '()))) #true)
(check-expect (pos? (cons -1 '())) #false)
(check-expect (pos? (cons 1 (cons -2 '()))) #false)


; Checks to see if given list of numbers is a list of amounts
(define (pos? l)
  (cond
    [(empty? l) #true]
    [(cons? l)
     (cond
       [(positive? (first l)) (pos? (rest l))]
       [else #false])]))

(check-expect (sum (cons 1 '()))
              1)
(check-expect (sum (cons 1 (cons 2 '())))
              3)
; sums list of positive numbers
(define (sum l)
  (cond
    [(empty? l) 0]
    [(cons? l)
     (+ (first l) (sum (rest l)))]))


(check-error (checked-sum (cons -1 '()))
             "list contains non-positive")
(check-error (checked-sum (cons 1 (cons -2 '())))
             "list contains non-positive")
(check-expect (checked-sum (cons 1 (cons 2 '())))
              3)
(define (checked-sum l)
  (if (pos? l)
      (sum l)
      (error "list contains non-positive")))