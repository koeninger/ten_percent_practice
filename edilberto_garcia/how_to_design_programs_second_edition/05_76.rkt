;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_76) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 76. Formulate data definitions for the following structure type definitions:

; Make sensible assumptions as to what kind of values go into each field.

;A Movie is (make-movie String String Number)
(define-struct movie [title producer year])
; A String being one of infinite movie titles
; A String being one of inifinite movie producers
; A Number being a year from 1800 - 2019

;A person is (make-person String String String String)
(define-struct person [name hair eyes phone])
; A String being one of inifinite names
; A String being one of a range of hair colors
; A String being one of a range of eye colors
; A String being on of a range of phone numbers

; A pet is (make-pet String String)
(define-struct pet [name number])
; A String being one of inifinite names
; A String being one of a range of pet numbers

; A CD is (make-CD String String Int)
(define-struct CD [artist title price])
; A String being one of infinite artist names
; A String being one of infinite CD titles
; An Int being one from a range of currency amounts

; A sweater is (make-sweater String String String)
(define-struct sweater [material size producer])
; A String being one from a range of materials
; A String being one from a range of materials
; A String being one from a open list of producers




