;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 121|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(+ (* (/ 12 8) 2/3)
   (- 20 (sqrt 4)))

; 12/8 = 3/2
; 3/2 * 2/3 = 1
; sqrt(4) = 2
; 20 - 2 = 18
; 1 + 18 = 19

(cond
  [(= 0 0) #false]
  [(> 0 1) (string=? "a" "a")]
  [else (= (/  1 0) 9)])

; 0 == 0 = #true skip other conditions
; return #false


(cond
  [(= 2 0) #false]
  [(> 2 1) (string=? "a" "a")]
  [else (= (/  1 2) 9)])

; 2 == 0 = #false go to next condition
; 2 > 1 = #true
; "a" == "a" so return #true

(define (f x y)
  (+ (* 3 x) (* y y)))


(+ (f 1 2) (f 2 1))
; (f 1 2) = 7
; (f 2 1) = 7
; 7 + 7 = 14

(f 1 (* 2 3))
; 2 * 3 = 6
; (f 1 6) = 39

(f (f 1 (* 2 3)) 19)
; 2 * 3 = 6
; (f 1 6) = 39
; (f 39 19) = 478

;(cond
;  [exp-test exp-then]
;  [else exp-else])

(define PRICE 5)
(define SALES-TAX (* 0.08 PRICE))
(define TOTAL (+ PRICE SALES-TAX))

(define COLD-F 32)
; ERROR because function used before defined
;(define COLD-C (fahrenheit->celsius COLD-F))
;(define (fahrenheit->celsius f)
; (* 5/9 (- f 32)))

(define LEFT -100)
(define RIGHT 100)
(define (g x) (+ (* 5 (expt x 2)) 10))
(define g@LEFT (g LEFT))
(define g@RIGHT (g RIGHT))

(define-struct oops [])
; legal
(define-struct child [parents dob date])
; legal
;(define-struct (child person) [dob date])
;illegal - (child person) not a single variable name

(define-struct point [x y z])
(define-struct none  [])

(make-point 1 2 3)
; (make-point 1 2 3)
(make-point (make-point 1 2 3) 4 5)
; (make-point (make-point 1 2 3) 4 5)
(make-point (+ 1 2) 3 4)
; (make-point 3 3 4)
(make-none)
; (make-none)
(make-point (point-x (make-point 1 2 3)) 4 5)
; (make-point 1 4 5)

(define-struct ball [x y speed-x speed-y])

(number? (make-ball 1 2 3 4))
; false
(ball-speed-y (make-ball (+ 1 2) (+ 3 3) 2 3))
; 3
(ball-y (make-ball (+ 1 2) (+ 3 3) 2 3))
; 6
;(ball-x (make-posn 1 2))
; ERROR requires a ball structure
;(ball-speed-y 5)
; ERROR ball-speed-y expects a ball structure

(check-member-of "green" "red" "yellow" "grey")
; green is not a red, yellow or grey
(check-within (make-posn #i1.0 #i1.1)
              (make-posn #i0.9 #i1.2)  0.01)
; not within
(check-range #i0.9 #i0.6 #i0.8)
; .9 is not between .6 and .8
(check-random (make-posn (random 3) (random 9))
              (make-posn (random 9) (random 3)))
; random 3 will not equal random 9
(check-satisfied 4 odd?)
; 4 is not odd