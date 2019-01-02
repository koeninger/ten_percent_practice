;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex66) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct movie [title producer year])
(make-movie "Into the Spider Verse" "Amy Pascal" 2018)

(define-struct person [name hair eyes phone])
(make-person "Eric" "Strawberry Blonde" 5165550369)

(define-struct pet [name number])
(make-pet "Goldie" 5165550369)

(define-struct CD [artist title price])
(make-CD "Gorillaz" "Humanz" 19.99)

(define-struct sweater [material size producer])
(make-sweater "wool" "XL" "Zales")
