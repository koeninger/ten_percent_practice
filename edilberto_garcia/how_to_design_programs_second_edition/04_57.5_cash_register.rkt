;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_57.5_cash_register) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Sample Problem The state of Tax Land has created a three-stage sales tax to cope with
;    its budget deficit. Inexpensive items, those costing less than $1,000, are not taxed.
;    Luxury items, with a price of more than $10,000, are taxed at the rate of eight percent
;    (8.00%). Everything in between comes with a five percent (5.00%) markup.


;Design a function for a cash register that, given the price of an item,
;    computes the sales tax.

; A Price falls into one of three intervals: 
; — 0 through 1000
; — 1000 through 10000
; — 10000 and above.
; interpretation the price of an item


; Price -> Number
; computes the amount of tax charged for p
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 12017) (* 0.08 12017))
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 1282) (* 0.05 1282))
(check-expect (sales-tax 10000) (* 0.05 10000))
(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p 1000)) 0]
    [(and (<= 1000 p) (<= p 10000)) (* 0.05 p)]
    [(> p 10000) (* 0.08 p)] )
 
 )

; What do you do when one of your test cases fails? Review the end of Designing Functions
;    concerning test failures.

;You miscalculated and determined the wrong expected output for some of the examples.

;Alternatively, the function definition computes the wrong result. When this is the case, you have a logical error in your program, also known as a bug.

;Both the examples and the function definition are wrong.

;When you do encounter a mismatch between expected results and actual values, we recommend that you first reassure yourself that the expected results are correct. If so, assume that the mistake is in the function definition. Otherwise, fix the example and then run the tests again. If you are still encountering problems, you may have encountered the third, somewhat rare, situation.