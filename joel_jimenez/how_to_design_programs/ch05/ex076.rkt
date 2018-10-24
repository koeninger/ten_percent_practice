;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex076) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct movie [title producer year])
; A Movie is a structure:
;   (make-movie String String Number)
; INTERPRENTATION a movie's title, producer name, and year released

(define-struct person [name hair eyes phone])
; A Person is a structure:
;   (make-person String String String Number)
; INTERPRENTATION a person's name, hair color, eye color, and phone number

(define-struct pet [name number])
; A Pet is a structure:
;   (make-pet String Number)
; INTERPRENTATION a pet's name, and number

(define-struct CD [artist title price])
; A CD is a structure:
;   (make-CD String String Number)
; INTERPRENTATION a CD's artist name, album title, and price

(define-struct sweater [material size producer])
; A Sweater is a structure:
;   (make-sweater String String Number)
; INTERPRENTATION a sweater's material, size, and producer
