;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex58) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


(define (low p)
  (and (<= 0 p) (< p 1000)))
(define (medium p)
  (and (<= 1000 p) (< p 10000)))
(define (luxury p)
  (>= p 10000))
  
(define (sales-tax p)
  (cond
    [(low p) 0]
    [(medium p) (* 0.05 p)]
    [(high p) (* 0.08 p)]))