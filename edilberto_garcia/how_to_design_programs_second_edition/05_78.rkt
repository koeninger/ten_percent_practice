;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_78) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 78. Provide a structure type and a data definition for representing three-letter words.
;    A word consists of lowercase letters, represented with the 1Strings "a" through "z" plus #false.
;    Note This exercise is a part of the design of a hangman game; see exercise 396.

(define-struct three-letter-word [letter1 letter2 letter3])
; A three-letter-word is one of
; - a series of three 1Strings "a" through "z"
; - #false
