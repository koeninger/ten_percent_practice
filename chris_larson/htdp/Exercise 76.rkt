;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 76|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; Movie is (make-movie String String Number)
(define-struct movie [title producer year])

; Person is (make-person String String String Number)
(define-struct person [name hair eyes phone])

; Pet is (make-pet String Number)
(define-struct pet [name number])

; CD is (make-CD String String Number)
(define-struct CD [artist title price])

; Sweater is (make-sweater Number String)
(define-struct sweater [material size producer])

; PointInTime is (make-point-in-tim Number Number Number)
; interpretation hours, minutes and seconds since midnight
(define-struct point-in-time [hours minutes seconds])

; ThreeLetterWord is (make-three-letter-word 1StringOrFalse 1StringOrFalse 1StringOrFalse)
; interpretation can be a 1String or #false
(define-struct three-letter-word [first second third])

; A Color is one of:
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"

; H is a Number between 0 and 100.
; interpretation represents a happiness value
; - 0
; - 100
; - 36

(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)
; (make-person "First" "Last" #False)
; (make-person "George" "Martin" #True)

(define-struct dog [owner name age happiness])
; A Dog is a structure:
;  (make-dog Person String PositiveInteger H)
;  (make-dog (make-person "George" "Martin" #True) "Frodo" 98)

; A Weapon is one of:
; — #false
; — Posn
; interpretation #false means the missile hasn't
; been fired yet; a Posn means it is in flight
; (make-weapon (make-posn 10 23))
; (make-weapon #False


