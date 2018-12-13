;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 136|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; List-of-names -> Boolean
; determines whether "Flatt" occurs on alon
(check-expect
  (contains-flatt? (cons "X" (cons "Y"  (cons "Z" '()))))
  #false)
(check-expect
  (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '()))))
  #true)
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) "Flatt")
         (contains-flatt? (rest alon)))]))

(contains-flatt? (cons "Fagan"
  (cons "Findler"
    (cons "Fisler"
      (cons "Flanagan"
        (cons "Flatt"
          (cons "Felleisen"
            (cons "Friedman" '()))))))))

(define (contains? key alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) key)
         (contains-flatt? (rest alon)))]))
(check-expect
  (contains? "Flatt" (cons "X" (cons "Y"  (cons "Z" '()))))
  #false)
(check-expect
  (contains? "Flatt" (cons "A" (cons "Flatt" (cons "C" '()))))
  #true)

(contains-flatt? (cons "Flatt" (cons "C" '())))

(contains-flatt?
  (cons "A" (cons "Flatt" (cons "C" '()))))


(define-struct pair [left right])
; A ConsPair is a structure:
;   (make-pair Any Any).
; Any Any -> ConsOrEmpty
(define (our-cons a-value a-list)
  (cond
    [(empty? a-list) (make-pair a-value a-list)]
    [(pair? a-list) (make-pair a-value a-list)]
    [else (error "cons: second argument ...")]))

; ConsOrEmpty -> Any
; extracts the left part of the given pair
(define (our-first a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-left a-list)))

; ConsOrEmpty -> List
; extracts the right part of the given pair
(define (our-rest a-list)
  (pair-right a-list))
(our-first (our-cons "a" '()))
(our-rest (our-cons "a" '()))

; contains-flatt? is checked by cons? but seems redundant becasue else recieves (rest x) which should be a cons

; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)

(cons 45 (cons 50 (cons 433 '())))

; List-of-amounts -> PositiveNumber
; adds all the numbers together
(define (sum loa)
  (cond
    [(empty? loa) 0]
    [else (+ (first loa) (sum (rest loa)))]))
(check-expect (sum (cons 10 (cons 10 (cons 10 (cons 10 '()))))) 40)

; List-of-numbers -> Boolean
; determins if all items are positive
(define (pos? lon)
  (cond
    [(empty? lon) #true]
    [else (and (positive? (first lon)) (pos? (rest lon)))]))
(check-expect (pos? (cons 10 (cons 10 '()))) #true)
(check-expect (pos? (cons -10 (cons 10 '()))) #false)
(check-expect (pos? (cons 10 (cons -10 '()))) #false)

; Any Any -> vec
; makes a vector from x and y
; if x and y are numbers
(define (checked-sum lon)
  (cond
    [(pos? lon) (sum lon)]
    [else (error "check-sum: list of positive numbers expected")]))

