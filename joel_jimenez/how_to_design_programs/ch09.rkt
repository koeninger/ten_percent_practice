;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ch09) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-strings is one of:
; – '()
; – (cons String List-of-strings)

; List-of-strings -> Number
; counts how many strings alos contains
(check-expect (how-many '()) 0)
(check-expect (how-many (cons "a" '())) 1)
(check-expect (how-many (cons "b" (cons "a" '()))) 2)
(define (how-many alos)
  (cond
    [(empty? alos) 0]
    [else (+ (how-many (rest alos)) 1)]))


; Exercise 137. Compare the template for contains-flatt? with the one for how-many.
;               Ignoring the function name, they are the same. Explain the similarity.
; They both call themselves untill the condition empty? is #true


; Exercise 138. Here is a data definition for representing sequences of amounts of money:

; A List-of-amounts is one of:
; – '()
; – (cons PositiveNumber List-of-amounts)

; Create some examples to make sure you understand the data definition.
; Also add an arrow for the self-reference.
; Design the sum function, which consumes a List-of-amounts and computes the sum of the amounts.
; Use DrRacket’s stepper to see how (sum l) works for a short list l in List-of-amounts.

'() ; by the first clause
(cons 1 '()) ; by the second clause, previous example
(cons 2 (cons 1 '())); by the second clause, previous example

; List-of-amounts -> Number
; computes the sum of the amounts aloa contains
(check-expect (sum '()) 0)
(check-expect (sum (cons 1 '())) 1)
(check-expect (sum (cons 2 (cons 1 '()))) 3)
(define (sum aloa)
  (cond
    [(empty? aloa) 0]
    [else (+ (first aloa) (sum (rest aloa)))]))
