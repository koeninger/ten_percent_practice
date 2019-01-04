;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 170|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct work [employee rate hours])
; A (piece of) Work is a structure: 
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name 
; with the pay rate r and the number of hours h

; Low (short for list of works) is one of: 
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the 
; hours worked for a number of employees

(define-struct paycheck [employee amount])
; a paycheck is a structure:
;  (make-paycheck String Number)
; interpretation (make-paycheck n a)
; combines the name with the paycheck amount

'()
(cons (make-work "Robby" 11.95 39)
      '())
(cons (make-work "Matthew" 12.95 45)
      (cons (make-work "Robby" 11.95 39)
            '()))
(cons (make-work "Joseph" 34.45 36)
      (cons (make-work "Jimmy" 65.78 42)
            '()))
; Low -> List-of-numbers
; computes the weekly wages for all weekly work records 
 
(check-expect
  (wage*.v2 (cons (make-work "Robby" 11.95 39) '()))
  (cons (* 11.95 39) '()))
 
(define (wage*.v2 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v2 (first an-low))
                          (wage*.v2 (rest an-low)))]))
 
; Work -> Number
; computes the wage for the given work record w
(define (wage.v2 w)
  (* (work-rate w) (work-hours w)))

(check-expect
  (wage*.v3 (cons (make-work "Robby" 11.95 39) '()))
  (cons (make-paycheck "Robby" (* 11.95 39)) '()))
 
(define (wage*.v3 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v3 (first an-low))
                          (wage*.v3 (rest an-low)))]))

; Work -> Paycheck
; computes the wage for the given work record w
(define (wage.v3 w)
  (make-paycheck (work-employee w) (* (work-rate w) (work-hours w))))

; v4
(define-struct work.v4 [employee number rate hours])
; A (piece of) Work is a structure: 
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name 
; with the pay rate r and the number of hours h

; Low (short for list of works) is one of: 
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the 
; hours worked for a number of employees

(define-struct paycheck.v4 [employee number amount])
; a paycheck is a structure:
;  (make-paycheck String Number)
; interpretation (make-paycheck n a)
; combines the name with the paycheck amount
(check-expect
  (wage*.v4 (cons (make-work.v4 "Robby" 333 11.95 39) '()))
  (cons (make-paycheck.v4 "Robby" 333 (* 11.95 39)) '()))
 
(define (wage*.v4 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v4 (first an-low))
                          (wage*.v4 (rest an-low)))]))

; Work -> Paycheck
; computes the wage for the given work record w
(define (wage.v4 w)
  (make-paycheck.v4 (work.v4-employee w) (work.v4-number w)  (* (work.v4-rate w) (work.v4-hours w))))

; List-of-posn -> Number
; sums all x coordinates
(define (sum lop)
  (cond
    [(empty? lop) 0]
    [else (+ (posn-x (first lop)) (sum (rest lop)))]))
(check-expect (sum '()) 0)
(check-expect (sum (cons (make-posn 1 1) '())) 1)
(check-expect (sum (cons (make-posn 1 1) (cons (make-posn 1 1) '()))) 2)

; List-of-posn -> List-of-posn
; adds 1 to all y coordinates
(define (translate lop)
  (cond
    [(empty? lop) '()]
    [else (cons (make-posn (posn-x (first lop)) (+ 1 (posn-y (first lop)))) (translate (rest lop)))]))
(check-expect (translate '()) '())
(check-expect (translate (cons (make-posn 1 1) '())) (cons (make-posn 1 2) '()))

; List-of-posn -> List-of-posn
; only returns posn within limits
(define (legal lop)
  (cond
    [(empty? lop) '()]
    [(and (> (posn-x (first lop)) 0) (< (posn-x (first lop)) 100) (> (posn-y (first lop)) 0) (< (posn-y (first lop)) 200)) (cons (first lop) (legal (rest lop)))]
    [else (rest lop)]))

(check-expect (legal '()) '())
(check-expect (legal (cons (make-posn 101 100) '())) '())
(check-expect (legal (cons (make-posn 50 100) '())) (cons (make-posn 50 100) '()))
(check-expect (legal (cons (make-posn 101 100) (cons (make-posn 50 100) '()))) (cons (make-posn 50 100) '()))

(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999. 
; A Four is a Number between 1000 and 9999. 

; List-of-phone -> List-of-phone
; replaces all 713 arecodes with 281
(define (replace lop)
  (cond
    [(empty? lop) '()]
    [(= 713 (phone-area (first lop))) (cons (make-phone 281 (phone-switch (first lop)) (phone-four (first lop))) (replace (rest lop)))]
    [else (cons (first lop) (replace (rest lop)))]))

(check-expect (replace '()) '())
(check-expect (replace (cons (make-phone 777 777 7777) (cons (make-phone 713 777 7777) '()))) (cons (make-phone 777 777 7777) (cons (make-phone 281 777 7777) '())))