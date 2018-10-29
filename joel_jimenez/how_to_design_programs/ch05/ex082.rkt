;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex082) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct word [letter1 letter2 letter3])
; A Word is a structure:
;   (make-word 1Strings|#false 1Strings|#false 1Strings|#false)
; INTERPRENTATION a three-letter word where each character has a value of 1Strings or #false


(define w1 (make-word "c" "a" "t"))
(define w2 (make-word "c" "a" "t"))
(define w3 (make-word "b" "a" "t"))


; Word Word -> Word
; produces a word that indicates where the given ones agree and disagree

(check-expect (compare-word w1 w2) (make-word "c" "a" "t"))
(check-expect (compare-word w1 w3) (make-word #false "a" "t"))

(define (compare-word w1 w2)
  (make-word
    (compare-1string (word-letter1 w1) (word-letter1 w2))
    (compare-1string (word-letter2 w1) (word-letter2 w2))
    (compare-1string (word-letter3 w1) (word-letter3 w2))))


; 1string 1string -> 1string | #false
; compares two 1string. if diff, return #false; else returns 1string

(check-expect (compare-1string "a" "a") "a")
(check-expect (compare-1string "a" "b") #false)

(define (compare-1string s1 s2)
  (if (string=? s1 s2)
      s1 #false))
