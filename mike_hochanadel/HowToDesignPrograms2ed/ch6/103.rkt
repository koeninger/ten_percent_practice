;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |103|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct space-numbers [l w h])
; A Space Numbers is a structure
;   (make-space-numbers Number Number Number),
; interpretation (make-space-numbers l w h) specifies the relative
; space it fills

; A Zoo Animal has is one of:
; - Spider
; - Elephant
; - Boa Constrictor
; - Armadillo
; interpretation is an enumeration of structs that all have a space

; A Spider is a structure:
;   (make-spider space-numbers Number)
; interpretation (make-spider sp l) specifies the space it fills
;   and then number of legs it has
(define-struct spider [sp l])

; An Elephant is a structure:
;   (make-elephant space-numbers)
; interpretation (make-elephant sp) specifies the space it fills
(define-struct elephant [sp])

; A Boa Constrictor is a structure:
;   (make-boa-constrictor space-numbers Number Number)
; interpretation (make-boa-constrictor sp l g) specifies the space it fills
;   and the length and girth of the boa constrictor respectively
(define-struct boa-constrictor [sp l g])

; An Armadillo is a structure:
;   (make-armadillo space-numbers Number)
; interpretation (make-armadillo sp t) specifies the space it fills
;   and the length of the tail it has
(define-struct armadillo [sp t])

; A Cage is a space-numbers
; intepretaion is that it is an empty space

; function template
;  (cond
;    [(spider?) ...]
;    [(elephant?) ...]
;    [(boa-constrictor?) ...]
;    [(armadillo?) ...]
;    [else])

; space-numbers, space-numbers -> boolean
; smaller-space? returns #true when each of the first spaces attributes
; is smaller than the latters
(check-expect (smaller-space? (make-space-numbers 3 3 3) (make-space-numbers 4 4 4)) #true)
(check-expect (smaller-space? (make-space-numbers 4 3 3) (make-space-numbers 4 4 4)) #true)
(check-expect (smaller-space? (make-space-numbers 3 4 3) (make-space-numbers 4 4 4)) #true)
(check-expect (smaller-space? (make-space-numbers 3 3 4) (make-space-numbers 4 4 4)) #true)
(check-expect (smaller-space? (make-space-numbers 3 4 4) (make-space-numbers 4 4 4)) #true)
(check-expect (smaller-space? (make-space-numbers 4 4 3) (make-space-numbers 4 4 4)) #true)
(check-expect (smaller-space? (make-space-numbers 4 4 4) (make-space-numbers 4 4 4)) #true)
(check-expect (smaller-space? (make-space-numbers 4 3 4) (make-space-numbers 4 4 4)) #true)
(check-expect (smaller-space? (make-space-numbers 5 3 3) (make-space-numbers 4 4 4)) #false)
(check-expect (smaller-space? (make-space-numbers 3 5 3) (make-space-numbers 4 4 4)) #false)
(check-expect (smaller-space? (make-space-numbers 3 3 5) (make-space-numbers 4 4 4)) #false)
(check-expect (smaller-space? (make-space-numbers 3 5 5) (make-space-numbers 4 4 4)) #false)
(check-expect (smaller-space? (make-space-numbers 5 5 3) (make-space-numbers 4 4 4)) #false)
(check-expect (smaller-space? (make-space-numbers 5 3 5) (make-space-numbers 4 4 4)) #false)
(check-expect (smaller-space? (make-space-numbers 5 5 5) (make-space-numbers 4 4 4)) #false)
(define (smaller-space? x y)
  (cond
    [(> (space-numbers-l x) (space-numbers-l y)) #false]
    [(> (space-numbers-w x) (space-numbers-w y)) #false]
    [(> (space-numbers-h x) (space-numbers-h y)) #false]
    [else #true]))
 
; Zoo Animal, Cage -> boolean
; fits? checks to see if the Animal can fit in the Cage
(check-expect (fits? (make-spider (make-space-numbers 3 3 3) 8) (make-space-numbers 4 4 4)) #true)
(check-expect (fits? (make-spider (make-space-numbers 5 5 5) 8) (make-space-numbers 4 4 4)) #false)
(check-expect (fits? (make-elephant (make-space-numbers 3 3 3)) (make-space-numbers 4 4 4)) #true)
(check-expect (fits? (make-elephant (make-space-numbers 5 5 5)) (make-space-numbers 4 4 4)) #false)
(check-expect (fits? (make-boa-constrictor (make-space-numbers 3 3 3) 2 9) (make-space-numbers 4 4 4)) #true)
(check-expect (fits? (make-boa-constrictor (make-space-numbers 5 5 5) 2 9) (make-space-numbers 4 4 4)) #false)
(check-expect (fits? (make-armadillo (make-space-numbers 3 3 3) 8) (make-space-numbers 4 4 4)) #true)
(check-expect (fits? (make-armadillo (make-space-numbers 5 5 5) 8) (make-space-numbers 4 4 4)) #false)
(define (fits? a c)
  (cond
    [(spider? a) (smaller-space? (spider-sp a) c)]
    [(elephant? a) (smaller-space? (elephant-sp a) c)]
    [(boa-constrictor? a) (smaller-space? (boa-constrictor-sp a) c)]
    [(armadillo? a) (smaller-space? (armadillo-sp a) c)]
    [else #false]))