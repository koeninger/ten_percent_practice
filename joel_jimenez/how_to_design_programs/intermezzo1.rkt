;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname intermezzo1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 116
; 1. x is a name
; 2. (= y z) is an expression
; 3. (= (= y z) 0) is a nested expression

; Exercise 117
; 1. (3 + 4) ; primitive must come first instide paranthesis
; 2. number? ; requires paranthesis and a variable
; 3. (x) ; Name cannot come first instide paranthesis

; Exercise 118.
; 1. (define (f x) x) ; def
; 2. (define (f x) y) ; def
; 3. (define (f x y) 3) ; def

; Exercise 119.
; 1. (define (f "x") x) ; value cannot be used as name on variable
; 2. (define (f x y z) (x)) ; name cannot come first instide paranthesis

; Exercise 120. Discriminate the legal from the illegal sentences:
; 1. (x) ; Illegal expression, name cannot come first instide paranthesis
; 2. (+ 1 (not x)) legal expression
; 3. (+ 1 2 3) legal expression


; Exercise 121. Evaluate the following expressions step-by-step:

; 1. (+ (* (/ 12 8) 2/3)(- 20 (sqrt 4)))
; (+ (* 1.25 2/3)(- 20 2))
; (+ 1 18)
; 19
(+ (* (/ 12 8) 2/3)(- 20 (sqrt 4)))

; 2. (cond [(= 0 0) #false] [(> 0 1) (string=? "a" "a")] [else (= (/  1 0) 9)])
; (cond [#true #false] [(> 0 1) (string=? "a" "a")] [else (= (/  1 0) 9)])
; [#true #false]
; #false
(cond
  [(= 0 0) #false]
  [(> 0 1) (string=? "a" "a")]
  [else (= (/  1 0) 9)])

; 3. (cond [(= 2 0) #false] [(> 2 1) (string=? "a" "a")] [else (= (/  1 2) 9)])
; (cond [#false #false] [#true (string=? "a" "a")] [else (= (/  1 2) 9)])
; [#true (string=? "a" "a")]
; (string=? "a" "a")
; #true
(cond
  [(= 2 0) #false]
  [(> 2 1) (string=? "a" "a")]
  [else (= (/  1 2) 9)])


; Exercise 122. Suppose the program contains these definitions:
(define (f x y)
  (+ (* 3 x) (* y y)))

; 1. (+ (f 1 2) (f 2 1))
; (+ (+ (* 3 1) (* 2 2)) (+ (* 3 2) (* 1 1)))
; (+ (+ 3 4) (+ 6 1))
; (+ 7 7)
; 14
(+ (f 1 2) (f 2 1))

; 2. (f 1 (* 2 3))
; (f 1 6)
; (+ (* 3 1) (* 6 6))
; (+ 3 36)
; 39
(f 1 (* 2 3))

; 3. (f (f 1 (* 2 3)) 19)
; (f (f 1 6) 19)
; (f (+ (* 3 1) (* 6 6)) 19)
; (f (+ 3 36) 19)
; (f 39 19)
; (+ (* 3 39) (* 19 19))
; (+ 117 361)
; 478
(f (f 1 (* 2 3)) 19)


; Exercise 123. (if exp-test exp-then exp-else)
; (cond
;   [exp-test exp-then]
;   [else exp-else]


; Exercise 124.

(define PRICE 5)
(define SALES-TAX (* 0.08 PRICE))
(define TOTAL (+ PRICE SALES-TAX))
; (define TOTAL (+ PRICE (* 0.08 PRICE)))
; (define TOTAL (+ 5 (* 0.08 5)))
; (define TOTAL (+ 5 0.4))
; (define TOTAL 5.4)

; (define COLD-F 32)
; (define COLD-C (fahrenheit->celsius COLD-F))
; (define (fahrenheit->celsius f)
;   (* 5/9 (- f 32)))
; Signals error, function fahrenheit->celsius is being called before its definition

(define LEFT -100)
(define RIGHT 100)
(define (g x) (+ (* 5 (expt x 2)) 10))
(define f@LEFT (g LEFT))
(define f@RIGHT (g RIGHT))

;(define f@LEFT (f -100))
;(define f@LEFT (+ (* 5 (expt -100 2)) 10))
;(define f@LEFT (+ (* 5 10000) 10))
;(define f@LEFT (+ 50000 10))
;(define f@LEFT 50010)
;(define f@RIGHT (f 100))
;(define f@LEFT (+ (* 5 (expt 100 2)) 10))
;(define f@LEFT (+ (* 5 10000) 10))
;(define f@LEFT (+ 50000 10))
;(define f@LEFT 50010)
; No errors, f@LEFT == f@RIGHT
