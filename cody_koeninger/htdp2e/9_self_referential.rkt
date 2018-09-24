;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9_self_referential) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; 137
; both contains-flatt and how-many have the empty list as the base case, and recur on the rest of the list as the other case

; 138

; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)

; sum of a list of amounts
; list-of-amounts -> positive number
(check-expect (sum '()) 0)
(check-expect (sum (cons 1 '())) 1)
(check-expect (sum (cons 2 (cons 1 '()))) 3)
(define (sum aloa)
  (cond
    [(empty? aloa) 0]
    [(cons? aloa)
     (+ (first aloa) (sum (rest aloa)))]))


; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)

; are all of alon positive
; list-of-numbers -> boolean
(check-expect (pos? '()) #t)
(check-expect (pos? (cons 1 '())) #t)
(check-expect (pos? (cons 1 (cons -2 '()))) #f)
(define (pos? alon)
  (cond
    [(empty? alon) #t]
    [(cons? alon)
     (and (positive? (first alon)) (pos? (rest alon)))]))



; sum of a list of numbers, only if all positive
; list-of-numbers -> positive number
(check-expect (checked-sum '()) 0)
(check-expect (checked-sum (cons 1 '())) 1)
(check-expect (checked-sum (cons 2 (cons 1 '()))) 3)
(check-error (checked-sum (cons 2 (cons -1 '()))) "checked-sum: expected list of positive numbers")
(define (checked-sum ns)
  (cond
    [(empty? ns) 0]
    [(cons? ns)
     (cond
       [(positive? (first ns))
        (+ (first ns) (checked-sum (rest ns)))]
       [else (error 'checked-sum "expected list of positive numbers")])]))

; are all of the list of booleans true
; list-of-booleans -> boolean
(check-expect (all-true '()) #t)
(check-expect (all-true (cons #t '())) #t)
(check-expect (all-true (cons #t (cons #f '()))) #f)
(define (all-true bs)
  (cond
    [(empty? bs) #t]
    [(cons? bs)
     (and (first bs) (all-true (rest bs)))]))

; is one of the list of booleans true
; list-of-booleans -> boolean
(check-expect (one-true '()) #f)
(check-expect (one-true (cons #t '())) #t)
(check-expect (one-true (cons #t (cons #f '()))) #t)
(check-expect (one-true (cons #f (cons #f '()))) #f)
(define (one-true bs)
  (cond
    [(empty? bs) #f]
    [(cons? bs)
     (or (first bs) (one-true (rest bs)))]))


; List-of-string -> String
; concatenates all strings in l into one long string
 
(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect
  (cat (cons "ab" (cons "cd" (cons "ef" '()))))
  "abcdef")
 
(define (cat l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l) (cat (rest l)))]))



; ImageOrFalse is one of:
; – Image
; – #false

; number -> list-of-images -> ImageOrFalse
; returns the first image that isn't an n * n square, or #false
(check-expect (ill-sized? 2 '())
              #f)
(check-expect (ill-sized? 2 (cons (rectangle 2 2 "solid" "red") '()))
              #f)
(check-expect (ill-sized? 3 (cons (rectangle 2 2 "solid" "red") '()))
              (rectangle 2 2 "solid" "red"))
(check-expect (ill-sized? 2 (cons (rectangle 2 2 "solid" "red") (cons (rectangle 2 3 "solid" "red") '())))
              (rectangle 2 3 "solid" "red"))
(define (ill-sized? n imgs)
  (cond
    [(empty? imgs) #false]
    [(cons? imgs)
     (if (= n (image-height (first imgs)) (image-width (first imgs)))
         (ill-sized? n (rest imgs))
         (first imgs))]))

(define (how-many alos)
  (cond
    [(empty? alos) 0]
    [else (+ (how-many (rest alos)) 1)]))


; List-of-temperatures -> Number
; computes the average temperature
(check-expect
  (average (cons 1 (cons 2 (cons 3 '())))) 2)
(define (average alot)
  (/ (sum alot) (how-many alot)))

(define (checked-average ts)
  (if (empty? ts)
      (error 'checked-average "expected non-empty list")
      (average ts)))

; 144
; sum and how-many will work for NELs, because NEL is a subcategory of all lists, and they work for all numeric lists