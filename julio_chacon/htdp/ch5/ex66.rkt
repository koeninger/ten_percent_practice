;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex66) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct entry [name phone email])

(make-entry "Al Abe" "666-7771" "lee@x.me")

(define-struct movie [title producer year])
; make-movie constructor
; movie? predicate
; movie-title selector
; movie-producer selector
; movie-year selector

(make-movie "The Movie" "mov producer" 2012)

(define-struct person [name hair eyes phone])
; make-person constructor
; person? predicate
; person-name selector
; person-hair selector
; person-eyes selector
; person-phone selector

(make-person "julio" "black" "black" "555-5432")

(define-struct pet [name number])
; make-pet constructor
; pet? predicate
; pet-name selector
; pet-number selector

(make-pet "fido" 200)

(define-struct CD [artist title price])
; make-CD constructor
; CD? predicate
; CD-artist selector
; CD-title selector
; CD-price selector

(make-CD "the artist" "the title" 23.50)

(define-struct sweater [material size producer])
; make-sweater constructor
; sweater? predicate
; sweater-material selector
; sweater-size selector
; sweater-producer selector

(make-sweater "cotton" "L" "maker")