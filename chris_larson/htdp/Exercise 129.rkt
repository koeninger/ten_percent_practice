;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 129|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(cons "Mervury"
      (cons "Venus"
            (cons "Earth"
                  (cons "Mars"
                        (cons "Jupiter"
                              (cons "Saturn"
                                    (cons "Uransus"
                                          (cons "Neptune" '()))))))))

(cons "steak"
      (cons "french fries"
            (cons "beans"
                  (cons "bread"
                        (cons "water"
                              (cons "Brie cheese"
                                    (cons "ice cream" '())))))))

(cons "red"
      (cons "blue"
            (cons "yellow" '())))

(cons 0
  (cons 1
    (cons 2
      (cons 3
        (cons 4
          (cons 5
            (cons 6
              (cons 7
                (cons 8
                  (cons 9 '()))))))))))

(cons "Robbie Round"
  (cons 3
    (cons #true
      '())))

(cons "Findler" (cons "Jim" (cons "Jill" (cons "Jerry" (cons "Jessica" '())))))
; (cons "1" (cons "2" '())) "1" is a string and fits the definition of List-of-names

; A List-of-booleans is one of:
; - '()
; - (cons Boolean List-of-booleans)
; interpretation a list of booleans


(define-struct pair [left right])
; A ConsPair is a structure:
;   (make-pair Any Any).
 
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

; ConsOrEmpty -> List
; extracts the right part of the given pair
(define (our-rest a-list)
  (pair-right a-list))

