;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 8_lists) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(cons "mercury" (cons "venus" (cons "earth" (cons "mars" (cons "jupiter" (cons "saturn" (cons "uranus" (cons "neptune" '()))))))))

(cons "steak" (cons "french fries" (cons "beans" (cons "bread" (cons "water" '())))))

(cons "red" (cons "green" (cons "blue" '())))

(cons "jarod" (cons "omar" (cons "keith" (cons "jake" (cons "juan" '())))))

; (cons 2 '())  doesn't contain a string

; A list-of-boolean is one of
; '()
; (cons Boolean list-of-boolean)

(define-struct pair [left right])
; A ConsOrEmpty is one of: 
; – '()
; – (make-pair Any ConsOrEmpty)
; interpretation ConsOrEmpty is the class of all lists
 
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

; ConsOrEmpty -> Any
; extracts the right part of the given pair
(define (our-rest a-list)
  (if (empty? a-list)
      (error 'our-rest "expected non-empty list")
      (pair-right a-list)))


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

(contains-flatt?
 (cons "Fagan"
  (cons "Findler"
    (cons "Fisler"
      (cons "Flanagan"
        (cons "Flatt"
          (cons "Felleisen"
            (cons "Friedman" '()))))))))


; List-of-strings -> Boolean
; determines whether str occurs on alon
(check-expect
  (contains? "F" (cons "X" (cons "Y"  (cons "Z" '()))))
  #false)
(check-expect
  (contains? "Flatt" (cons "A" (cons "Flatt" (cons "C" '()))))
  #true)
(define (contains? str alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) str)
         (contains? str (rest alon)))]))

(contains-flatt? (cons "Flatt" (cons "C" '())))