;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 186|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; List-of-numbers -> List-of-numbers 
; produces a sorted version of alon
(define (sort> alon)
  (cond
    [(empty? alon) '()]
    [else
     (insert (first alon) (sort> (rest alon)))]))

(check-expect (sort> '()) '())
(check-expect (sort> (list 3 2 1)) (list 3 2 1))
(check-expect (sort> (list 1 2 3)) (list 3 2 1))
(check-expect (sort> (list 12 20 -5))
              (list 20 12 -5))
(check-satisfied (sort> (list 3 2 1)) sorted>?)
(check-satisfied (sort> (list 1 2 3)) sorted>?)
(check-satisfied (sort> (list 12 20 -5)) sorted>?)

; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers l 
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))

(check-expect (insert 5 '()) (list 5))
(check-expect (insert 5 (list 6)) (list 6 5))
(check-expect (insert 5 (list 4)) (list 5 4))
(check-expect (insert 12 (list 20 -5))
              (list 20 12 -5))

; NEList-of-temperatures -> boolean
; determins if the list is sorted
(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) #true]
    [else (and (> (first ne-l) (first (rest ne-l))) (sorted>? (rest ne-l)))]))
(check-expect (sorted>? (cons 10 (cons 9 (cons 8 '())))) #true)
(check-expect (sorted>? (cons 8 (cons 9 (cons 10 '())))) #false)

; List-of-numbers -> List-of-numbers
; produces a sorted version of l
;(define (sort>/bad l)
;  (list 9 8 7 6 5 4 3 2 1 0))
;(check-satisfied (sort>/bad (list 3 2 1)) sorted>?)
;(check-expect (length (sort>/bad (list 3 2 1))) (length (list 3 2 1)))
;(check-satisfied (sort>/bad (list 3 2 1)) length=3?)

; List-of-numbers -> boolean
; determines if lengths are the same
(define (length=3? l1 )
  (equal? (length l1) 3))

(define-struct gp [name score])
; A GamePlayer is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points

; GamePlayer GamePlayer -> Boolean
; Compares scores
(define (score>? gp1 gp2)
  (>= (gp-score gp1) (gp-score gp2)))
(check-expect (score>? (make-gp "1" 5) (make-gp "2" 4)) #true)
(check-expect (score>? (make-gp "1" 4) (make-gp "2" 5)) #false)

; GamePlayer List-of-GamePlayer -> List-of-GamePlayer
; inserts gp into the sorted list of GamePlayer l 
(define (insert-gp gp l)
  (cond
    [(empty? l) (cons gp '())]
    [else (if (score>? gp (first l))
              (cons gp l)
              (cons (first l) (insert-gp gp (rest l))))]))

(check-expect (insert-gp (make-gp "1" 5) '()) (list (make-gp "1" 5)))
(check-expect (insert-gp (make-gp "1" 5) (list (make-gp "1" 6))) (list (make-gp "1" 6) (make-gp "1" 5)))
(check-expect (insert-gp (make-gp "1" 5) (list (make-gp "1" 4))) (list (make-gp "1" 5) (make-gp "1" 4)))
(check-expect (insert-gp (make-gp "1" 12) (list (make-gp "1" 20) (make-gp "1" -5)))
              (list (make-gp "1" 20) (make-gp "1" 12) (make-gp "1" -5)))

(define-struct email [from date message])
; An Email Message is a structure: 
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m 
; sent by f, d seconds after the beginning of time

; email list-of-email -> list-of-email
; insters email into the sorted list of email
(define (insert-email e l)
  (cond
    [(empty? l) (cons e '())]
    [else (if (date>? e (first l))
              (cons e l)
              (cons (first l) (insert-email e (rest l))))]))
(check-expect (insert-email (make-email "me" 2 "yo!") '()) (list (make-email "me" 2 "yo!")))
(check-expect (insert-email (make-email "me" 5 "yo!") (list (make-email "me" 6 "yo!"))) (list (make-email "me" 6 "yo!") (make-email "me" 5 "yo!")))
(check-expect (insert-email (make-email "me" 5 "yo!") (list (make-email "me" 4 "yo!"))) (list (make-email "me" 5 "yo!") (make-email "me" 4 "yo!")))
(check-expect (insert-email (make-email "me" 12 "yo!") (list (make-email "me" 20 "yo!") (make-email "me" -5 "yo!")))
              (list (make-email "me" 20 "yo!") (make-email "me" 12 "yo!") (make-email "me" -5 "yo!")))

; Email Email -> Boolean
; compares dates of emails
(define (date>? e1 e2)
  (>= (email-date e1) (email-date e2)))