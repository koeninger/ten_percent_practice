;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |76|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct ball [location velocity])

; Posn is (make-posn Number Number)
(make-posn (make-posn 1 1) "hello")

(define-struct movie [title producer year])
; movie is (make-movie String String Number)
(define film (make-movie "A river runs through it" "Robert Redford" 1992))

(define-struct person [name hair eyes phone])
; person is (make-person String String String String)
(define teacher (make-person "John Doe" "brown" "brown" "123-456-7890")

(define-struct pet [name number])
; pet is (make-pet String Number)
(define dog (make-pet "rocket" 1345))

(define-struct CD [artist title price])
; CD is (make-CD String String Number)
(define album (make-CD "beatles" "sgt. pepper" 15.99))

(define-struct sweater [material size producer])
; sweater is (make-sweater String String String)
(define mysweater (make-sweater "cotton" "medium" "good threads"))
  