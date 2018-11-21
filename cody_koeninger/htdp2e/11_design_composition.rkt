;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 11_design_composition) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/universe)

; ex 181
(check-expect
 (cons "a" (cons "b" (cons "c" (cons "d" '()))))
 (list "a" "b" "c" "d"))

(check-expect
 (cons (cons 1 (cons 2 '())) '())
 (list (list 1 2)))

(check-expect
 (cons "a"
       (cons
        (cons 1 '())
        (cons #false '())))
 (list "a"
       (list 1)
       #false))

(check-expect
 (cons
  (cons "a"
        (cons 2 '()))
  (cons "hello" '()))
 (list (list "a" 2) "hello"))

(check-expect
 (cons
  (cons
   1
   (cons 2 '()))
  (cons
   (cons 2 '())
            '()))
 (list (list 1 2) (list 2)))

; ex 182
(check-expect (list 0 1 2 3 4 5)
              (cons 0 (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 '())))))))

(check-expect (list (list "he" 0) (list "it" 1) (list "lui" 14))
              (cons (cons "he" (cons 0 '())) (cons (cons "it" (cons 1 '())) (cons (cons "lui" (cons 14 '())) '()))))

(check-expect (list 1 (list 1 2) (list 1 2 3))
              (cons 1 (cons (cons 1 (cons 2 '())) (cons (cons 1 (cons 2 (cons 3 '()))) '()))))

; ex 183
(check-expect (cons "a" (list 0 #false))
              (list "a" 0 #false))

(check-expect (list (cons 1 (cons 13 '())))
              (list (list 1 13)))

(check-expect (cons (list 1 (list 13 '())) '())
              (list (list 1 (list 13 '()))))

(check-expect (list '() '() (cons 1 '()))
              (list '() '() (list 1)))

(check-expect (cons "a" (cons (list 1) (list #false '())))
              (list "a" (list 1) #false '()))

; ex 184
(check-expect (list (string=? "a" "b") #false)
              (list #false #false))

(check-expect (list (+ 10 20) (* 10 20) (/ 10 20))
              (list 30 200 0.5))

(check-expect (list "dana" "jane" "mary" "laura")
              (cons "dana" (cons "jane" (cons "mary" (cons "laura" '())))))

; ex 185

(check-expect (first (list 1 2 3))
              1)

(check-expect (rest (list 1 2 3))
              (list 2 3))

(check-expect (second (list 1 2 3))
              2)

(check-expect (third (list 1 2 3))
              3)


; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort> (rest l)))]))
 
; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers l 
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))

; ex 186

; true if sorted in descending order                                                                                                  
; list-of-numbers -> boolean                                                                                                                    
(check-expect (sorted>? (cons 1 '())) #t)
(check-expect (sorted>? (cons 2 (cons 1 '()))) #t)
(check-expect (sorted>? (cons 1 (cons 2 '()))) #f)
(define (sorted>? ts)
  (cond
    [(empty? ts) #t]
    [(empty? (rest ts)) #t]
    [else (and (> (first ts) (second ts))
               (sorted>? (rest ts)))]))


(check-satisfied (sort> '()) sorted>?)
(check-satisfied (sort> (list 3 2 1)) sorted>?)
(check-satisfied (sort> (list 1 2 3)) sorted>?)
(check-satisfied (sort> (list 12 20 -5)) sorted>?)

; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort>/bad l)
  (list 9 8 7 6 5 4 3 2 1 0))

; should fail, but doesn't
(check-satisfied (sort>/bad (list "a" "b" "c")) sorted>?)

; ex 187

(define-struct gp [name score])
; A GamePlayer is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points

; List-of-gp -> List-of-gp
; produces a descending sorted version of l
(check-expect (sort-gp> '()) '())
(check-expect (sort-gp> (list (make-gp "a" 23) (make-gp "b" 42) (make-gp "c" 5)))
              (list (make-gp "b" 42) (make-gp "a" 23) (make-gp "c" 5)))
(define (sort-gp> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert-gp (first l) (sort-gp> (rest l)))]))
 
; gp List-of-gp -> List-of-gp
; inserts gp into the sorted list of gp l
(check-expect (insert-gp (make-gp "b" 42) '())
              (list (make-gp "b" 42)))
(check-expect (insert-gp (make-gp "a" 23) (list (make-gp "b" 42) (make-gp "c" 5)))
              (list (make-gp "b" 42) (make-gp "a" 23) (make-gp "c" 5)))
(define (insert-gp gp l)
  (cond
    [(empty? l) (cons gp '())]
    [else (if (gp->= gp (first l))
              (cons gp l)
              (cons (first l) (insert-gp gp (rest l))))]))

; gp gp -> bool
; compare two gp by score
(check-expect (gp->= (make-gp "b" 42) (make-gp "a" 23))
              #t)
(check-expect (gp->= (make-gp "b" 42) (make-gp "a" 42))
              #t)
(check-expect (gp->= (make-gp "b" 12) (make-gp "a" 23))
              #f)
(define (gp->= g g2)
  (>= (gp-score g) (gp-score g2)))


; ex 188

(define-struct email [from date message])
; An Email Message is a structure: 
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m 
; sent by f, d seconds after the beginning of time 

; List-of-email -> List-of-email
; produces a descending sorted version of l
(check-expect (sort-email> '()) '())
(check-expect (sort-email> (list (make-email "a" 23 "hi") (make-email "b" 42 "hi") (make-email "c" 5 "hi")))
              (list (make-email "b" 42 "hi") (make-email "a" 23 "hi") (make-email "c" 5 "hi")))
(define (sort-email> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert-email (first l) (sort-email> (rest l)))]))
 
; email List-of-email -> List-of-email
; inserts email into the sorted list of email l
(check-expect (insert-email (make-email "b" 42 "hi") '())
              (list (make-email "b" 42 "hi")))
(check-expect (insert-email (make-email "a" 23 "hi") (list (make-email "b" 42 "hi") (make-email "c" 5 "hi")))
              (list (make-email "b" 42 "hi") (make-email "a" 23 "hi") (make-email "c" 5 "hi")))
(define (insert-email email l)
  (cond
    [(empty? l) (cons email '())]
    [else (if (email->= email (first l))
              (cons email l)
              (cons (first l) (insert-email email (rest l))))]))

; email email -> bool
; compare two email by date
(check-expect (email->= (make-email "b" 42 "hi") (make-email "a" 23 "hi"))
              #t)
(check-expect (email->= (make-email "b" 42 "hi") (make-email "a" 42 "hi"))
              #t)
(check-expect (email->= (make-email "b" 12 "hi") (make-email "a" 23 "hi"))
              #f)
(define (email->= g g2)
  (>= (email-date g) (email-date g2)))


; List-of-email -> List-of-email
; produces a descending sorted version of l by name
(check-expect (sort-email-name> '()) '())
(check-expect (sort-email-name> (list (make-email "b" 42 "hi") (make-email "a" 23 "hi") (make-email "c" 5 "hi")))
               (list (make-email "c" 5 "hi") (make-email "b" 42 "hi") (make-email "a" 23 "hi")))
  
(define (sort-email-name> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert-email-by-name (first l) (sort-email-name> (rest l)))]))
 
; email List-of-email -> List-of-email
; inserts email into the sorted list of email l
(check-expect (insert-email-by-name (make-email "b" 42 "hi") '())
              (list (make-email "b" 42 "hi")))
(check-expect (insert-email-by-name (make-email "b" 42 "hi") (list (make-email "c" 5 "hi") (make-email "a" 23 "hi")))
              (list (make-email "c" 5 "hi") (make-email "b" 42 "hi") (make-email "a" 23 "hi")))

(define (insert-email-by-name email l)
  (cond
    [(empty? l) (cons email '())]
    [else (if (email-name->= email (first l))
              (cons email l)
              (cons (first l) (insert-email-by-name email (rest l))))]))

; email email -> bool
; compare two email by from name
(check-expect (email-name->= (make-email "a" 23 "hi") (make-email "b" 42 "hi"))
              #f)
(check-expect (email-name->= (make-email "b" 42 "hi") (make-email "a" 42 "hi"))
              #t)
(check-expect (email-name->= (make-email "b" 12 "hi") (make-email "c" 23 "hi"))
              #f)
(define (email-name->= g g2)
  (string>=? (email-from g) (email-from g2)))

; ex 189

; Number List-of-numbers -> Boolean
; search for n in a descending sorted list of numbers
(check-expect (search-sorted 2 '()) #f)
(check-expect (search-sorted 2 (list 1 2 3 4)) #f)
(check-expect (search-sorted 2 (list 4 3 2 1)) #t)
(define (search-sorted n alon)
  (cond
    [(empty? alon) #false]
    [(> n (first alon)) #false]
    [else (or (= (first alon) n)
              (search-sorted n (rest alon)))]))

; ex 190

; list-of-1strings -> list-of-list-of-1strings
; list of all prefixes
(check-expect (prefixes '()) '())
(check-expect (prefixes (list "1" "2")) (list (list "1") (list "1" "2")))
(define (prefixes xs)
  (cond
    [(empty? xs) '()]
    [(cons? xs) (cons (list (first xs))
                      (cons-all (first xs) (prefixes (rest xs))))]))

; 1string list-of-list-of-1strings -> list-of-list-of-1strings
; prepend x on to each list in xs
(check-expect (cons-all "a" (list '()))
              (list (list "a")))
(check-expect (cons-all "1" (list (list "2") (list "2" "3")))
              (list (list "1" "2") (list "1" "2" "3")))
(define (cons-all x xs)
  (cond
    [(empty? xs) '()]
    [(cons? xs)
     (cons (cons x (first xs)) (cons-all x (rest xs)))]))

; list-of-1string -> list-of-list-of-1strings
; list of all suffixes
(check-expect (suffixes '()) '())
(check-expect (suffixes (list "1" "2"))
              (list (list "1" "2") (list "2")))
(define (suffixes xs)
  (cond
    [(empty? xs) '()]
    [(cons? xs)
     (cons xs (suffixes (rest xs)))]))

; ex 191

(define triangle-p
  (list
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 30 20)))
 
(define square-p
  (list
    (make-posn 10 10)
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 10 20)))

; a plain background image 
(define MT (empty-scene 50 50))

; An NELoP is one of: 
; – (cons Posn '())
; – (cons Posn NELoP)

; Image Posn Posn -> Image 
; renders a line from p to q into img
(check-expect (render-line MT (first square-p) (second square-p))
              (scene+line MT (posn-x (first square-p)) (posn-y (first square-p)) (posn-x (second square-p)) (posn-y (second square-p)) "red"))
(define (render-line img p q)
  (scene+line
    img
    (posn-x p) (posn-y p) (posn-x q) (posn-y q)
    "red"))

; Image NELoP -> Image 
; connects the dots in p by rendering lines in img
(check-expect (connect-dots MT triangle-p)
              (scene+line
               (scene+line MT 20 10 20 20 "red")
               20 20 30 20 "red"))
(check-expect
  (connect-dots MT square-p)
  (scene+line
   (scene+line
    (scene+line MT 10 10 20 10 "red")
    20 10 20 20 "red")
   20 20 10 20 "red"))
(define (connect-dots img p)
  (cond
    [(empty? (rest p)) img]
    [else
     (render-line
       (connect-dots img (rest p))
       (first p)
       (second p))]))

; Image Polygon -> Image 
; adds an image of p to img
(define (render-polygon img p)
  (render-line (connect-dots img p)
               (first p)
               (last p)))

; ex 192

; it's acceptable to use last on polygons, because they have at least three items, it's equivalent to say
; [(empty? (rest (rest (rest p)))) (third p)]
; or
; [(empty? (rest p)) (... (first p) ...)];

; Polygon -> Posn
; extracts the last item from p
(check-expect (last triangle-p) (make-posn 30 20))
(check-expect (last square-p) (make-posn 10 20))
(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))