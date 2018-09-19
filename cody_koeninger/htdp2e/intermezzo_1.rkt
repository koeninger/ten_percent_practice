;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname intermezzo_1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; 116

; variable
;x

;(primitive expr expr ...
;(= y z)

;(primitive expr expr ...
;(= (= y z) 0)

; 117

; expr primitive expr isn't in grammar
;(3 + 4)

; number is a procedure, BSL doesn't allow it without being applied
; number?

; x is a variable, application doesn't match (variable expr expr...)
;(x)

; 118

; all three match the case (define (variable variable variable ...) expr),
; because x and y are variables, and 3 is a value.  expr includes variables and values
;(define (f x) x)
;(define (f x) y)
;(define (f x y) 3)

; 119

; "x" is not a variable
;(define (f "x") x)

; (x) is not a valid expression, see 117
; (define (f x y z) (x))

; 120

; syntactically illegal, see 117
;(x)

; syntactically legal, expr semantically meaningless (adding 1 to boolean)
;(+ 1 (not x))

; legal expr
; (+ 1 2 3)

; 121

(+ (* (/ 12 8) 2/3)	   (- 20 (sqrt 4)))
(+ (* (/ 12 8) 2/3)	   (- 20 2))
(+ (* (/ 12 8) 2/3)	   18)
(+ (* 3/2 2/3)	   18)
(+ 1	   18)
19


(cond	  [(= 0 0) #false]	  [(> 0 1) (string=? "a" "a")]	  [else (= (/  1 0) 9)])
(cond	  [#true #false]	  [(> 0 1) (string=? "a" "a")]	  [else (= (/  1 0) 9)])
#false

(cond	  [(= 2 0) #false]	  [(> 2 1) (string=? "a" "a")]	  [else (= (/  1 2) 9)])
(cond	  [#false #false]	  [(> 2 1) (string=? "a" "a")]	  [else (= (/  1 2) 9)])
(cond	  [(> 2 1) (string=? "a" "a")]	  [else (= (/  1 2) 9)])
(cond	  [#true (string=? "a" "a")]	  [else (= (/  1 2) 9)])
(string=? "a" "a")
#true


(define (f x y)
  (+ (* 3 x) (* y y)))

(+ (f 1 2) (f 2 1))
(+ (+ (* 3 1) (* 2 2)) (f 2 1))
(+ (+ 3 (* 2 2)) (f 2 1))
(+ (+ 3 4) (f 2 1))
(+ 7 (f 2 1))
(+ 7 (+ (* 3 2) (* 1 1)))
(+ 7 (+ 6 (* 1 1)))
(+ 7 (+ 6 1))
(+ 7 7)
14


(f 1 (* 2 3))
(f 1 6)
(+ (* 3 1) (* 6 6))
(+ 3 (* 6 6))
(+ 3 36)
39

(f (f 1 (* 2 3)) 19)
(f (f 1 6) 19)
(f (+ (* 3 1) (* 6 6)) 19)
(f (+ 3 (* 6 6)) 19)
(f (+ 3 36) 19)
(f 39 19)
(+ (* 3 39) (* 19 19))
(+ 117 (* 19 19))
(+ 117 361)
478


; 123

; (if exp-test exp-then exp-else)
; (cond [exp-test exp-then] [else exp-else])


; 124

(define PRICE 5)
(define SALES-TAX (* 0.08 PRICE))
(define TOTAL (+ PRICE SALES-TAX))


; error
;(define COLD-F 32)
;(define COLD-C (fahrenheit->celsius COLD-F))
;(define (fahrenheit->celsius f)
;(* 5/9 (- f 32)))

(define LEFT -100)
(define RIGHT 100)
(define (f2 x) (+ (* 5 (expt x 2)) 10))
(define f@LEFT (f2 LEFT))
(define f@RIGHT (f2 RIGHT))

; 125

; ok
(define-struct oops [])
; ok
(define-struct child [parents dob date])
; error, application of child to person is not a name
;(define-struct (child person) [dob date])

; 126

(define-struct point [x y z])
(define-struct none  [])

; value
(make-point 1 2 3)
; value
(make-point (make-point 1 2 3) 4 5)
; value
(make-point (+ 1 2) 3 4)
; value
(make-none)
; value
(make-point (point-x (make-point 1 2 3)) 4 5)


; 127

(define-struct ball [x y speed-x speed-y])


(number? (make-ball 1 2 3 4))
; #f

(ball-speed-y (make-ball (+ 1 2) (+ 3 3) 2 3))
; 3

(ball-y (make-ball (+ 1 2) (+ 3 3) 2 3))
; 6

;(ball-x (make-posn 1 2))
; error

;(ball-speed-y 5)
; error


; 128

;(check-member-of "green" "red" "yellow" "grey")
; green not in list

;(check-within (make-posn #i1.0 #i1.1)
;              (make-posn #i0.9 #i1.2)  0.01)
; 0.01 tolerance is smaller than difference

;(check-range #i0.9 #i0.6 #i0.8)
; .9 is past the end of the range

;(check-random (make-posn (random 3) (random 9))
;              (make-posn (random 9) (random 3)))
; random 3 isn't the same as random 9

;(check-satisfied 4 odd?)
; 4 isn't odd