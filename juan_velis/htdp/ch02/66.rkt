;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |66|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;(define-struct movie [title producer year])
;(define-struct person [name hair eyes phone])
;(define-struct pet [name number])
;(define-struct CD [artist title price])
;(define-struct sweater [material size producer])

(define-struct movie [title producer year])
(define mv (make-movie "Gladiator" "John Smith" "2000"))
(movie-title mv)     
(movie-producer mv)  
(movie-year mv)     
(movie? mv)

(define-struct person [name hair eyes phone])
(define per (make-person "John" "Smith" "Brown" "123-4567"))

(define-struct pet [name number])
(define pet (make-pet "Rocky" 1))

(define-struct CD [artist title price])
(define disc (make-CD "John" "Album title" "15.99"))

(define-struct sweater [material size producer])
(define swt (make-sweater "cotton" "M" "good threads"))