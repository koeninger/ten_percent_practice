;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10_more_lists) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; List-of-numbers -> List-of-numbers
; computes the weekly wages for all given weekly hours
(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons 392 '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons 56 (cons 28 '())))
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (if (> (first whrs) 100)
              (error "too many hours")
              (cons (wage (first whrs)) (wage* (rest whrs))))]))
 
; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* 14 h))

; Number -> Number 
; converts Fahrenheit temperatures to Celsius
; given 32, expect 0
; given 212, expect 100
; given -40, expect -40
(define (f2c f)
  (* 5/9 (- f 32)))

; list-of-number -> list-of-number
; convert list of fahrenheit to list of celsius
(check-expect (convertFC '()) '())
(check-expect (convertFC (list 32)) (list 0))
(check-expect (convertFC (list 32 41)) (list 0 5))
(define (convertFC fs)
  (cond
    [(empty? fs) '()]
    [else (cons (f2c (first fs)) (convertFC (rest fs)))]))

; number list-of-number -> list-of-number
; given exchange rate and list of dollars, return list of euros
(check-expect (convert-euro* 0 '()) '())
(check-expect (convert-euro* 1.16 (list 10 20)) (list 11.6 23.2))
(define (convert-euro* r ds)
  (cond
    [(empty? ds) '()]
    [else (cons (* r (first ds)) (convert-euro* r (rest ds)))]))

; list-of-string -> list-of-string
; replace robot with r2d2
(check-expect (subst-robot '()) '())
(check-expect (subst-robot (list "bob" "robot" "ted")) (list "bob" "r2d2" "ted"))
(define (subst-robot rs)
  (cond
    [(empty? rs) '()]
    [else (cons (if (string=? "robot" (first rs))
                    "r2d2"
                    (first rs))
                (subst-robot (rest rs)))]))

; string string list-of-string -> list-of-string
; replace old with new in list of strings
(check-expect (substitute  "robot" "r2d2" '()) '())
(check-expect (substitute "robot" "c3p0" (list "bob" "robot" "ted")) (list "bob" "c3p0" "ted"))
(define (substitute old new rs)
  (cond
    [(empty? rs) '()]
    [else (cons (if (string=? old (first rs))
                    new
                    (first rs))
                (substitute old new (rest rs)))]))

(define-struct work [employee rate hours])
; A (piece of) Work is a structure: 
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name 
; with the pay rate r and the number of hours h

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

(define-struct paycheck [employee amount])
; employee and amount


; Low -> List-of-paycheck
; computes the weekly wages for all weekly work records  
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

(define-struct employee [name number])
; employee name and serial number

; Low -> List-of-paycheck
; computes the weekly wages for all weekly work records
; uses employee struct
(check-expect
  (wage*.v4 (cons (make-work (make-employee "Robby" 666) 11.95 39) '()))
  (cons (make-paycheck (make-employee "Robby" 666) (* 11.95 39)) '()))
(define (wage*.v4 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v4 (first an-low))
                          (wage*.v4 (rest an-low)))]))
 
; Work -> Paycheck
; computes the wage for the given work record w
(define (wage.v4 w)
  (make-paycheck (work-employee w) (* (work-rate w) (work-hours w))))


; list-of-posn -> number
; sum of x coordinates
(check-expect (sum (list (make-posn 1 23) (make-posn 2 42))) 3)
(define (sum ps)
  (cond
    [(empty? ps) 0]
    [(cons? ps) (+ (posn-x (first ps)) (sum (rest ps)))]))

; list-of-posn -> list-of-posn
; add 1 to each y coord
(check-expect (translate (list (make-posn 23 1) (make-posn 42 2))) (list (make-posn 23 2) (make-posn 42 3)))
(define (translate ps)
  (cond
    [(empty? ps) '()]
    [(cons? ps) (cons (make-posn (posn-x (first ps)) (+ 1 (posn-y (first ps)))) (translate (rest ps)))]))


; list-of-posn -> list-of-posn
; all those Posns whose x-coordinates are between 0 and 100 and whose y-coordinates are between 0 and 200
(check-expect (legal (list (make-posn -1 23) (make-posn 1 1) (make-posn 23 201)))
              (list (make-posn 1 1)))
(define (legal ps)
  (cond
    [(empty? ps) '()]
    [(cons? ps)
     (if (and (<= 0 (posn-x (first ps))) (<= (posn-x (first ps)) 100)
              (<= 0 (posn-y (first ps))) (<= (posn-y (first ps)) 200))
         (cons (first ps) (legal (rest ps)))
         (legal (rest ps)))]))

(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999. 
; A Four is a Number between 1000 and 9999. 

; list-of-phone -> list-of-phone
; replace 713 area code with 281
(check-expect (replace (list (make-phone 712 555 1212) (make-phone 713 555 1212)))
              (list (make-phone 712 555 1212) (make-phone 281 555 1212)))
(define (replace ps)
  (cond
    [(empty? ps) '()]
    [(cons? ps)
     (cons (make-phone (if (= 713 (phone-area (first ps))) 281 (phone-area (first ps)))
                       (phone-switch (first ps))
                       (phone-four (first ps)))
           (replace (rest ps)))]))
