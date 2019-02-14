;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex140) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))



(check-expect (all-true (cons #true '()))
              #true)
(check-expect (all-true (cons #true (cons #true '())))
              #true)
(check-expect (all-true (cons #false '()))
              #false)
(check-expect (all-true (cons #true (cons #false '())))
              #false)
; returns true if all items are #true. else returns false.
(define (all-true l)
  (cond
    [(empty? l) #true]
    [(cons? l)
     (cond
       [(first l) (all-true (rest l))]
       [else #false])]))




(check-expect (one-true (cons #true '()))
              #true)
(check-expect (one-true (cons #true (cons #true '())))
              #true)
(check-expect (one-true (cons #false '()))
              #false)
(check-expect (one-true (cons #true (cons #false '())))
              #true)
; returns true if at least one item is #true. else returns false
(define (one-true l)
  (cond
    [(empty? l) #false]
    [(cons? l)
     (cond
       [(not (first l)) (one-true (rest l))]
       [else #true])]))