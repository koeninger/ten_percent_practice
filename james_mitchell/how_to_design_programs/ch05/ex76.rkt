;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex76) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct movie [title producer year])
; movie is (make-movie String String Number)
(define film (make-movie "Se7en" "Brad Pitt" 1995))

(define-struct person [name hair eyes phone])
; person is (make-person String String String String)
(define teacher (make-person "George Bodega" "brown" "blue" "555-867-5309"))

(define-struct pet [name number])
; pet is (make-pet String Number)
(define dog (make-pet "Hans" 2008))

(define-struct CD [artist title price])
; CD is (make-CD String String Number)
(define album (make-CD "Offspring" "Ixnay on the Hombre" 17.99))

(define-struct sweater [material size producer])
; sweater is (make-sweater String String String)
(define mysweater (make-sweater "Wool" "extra large" "Kohls"))
