;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex82) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


; A Word is a three letter word:
;  (make-word char char char)
; Char can any of the following:
;  any 1String from "a" through "z"
;  #false
(define-struct word [c1 c2 c3])

; Char Char -> Char
; Compares two Chars.
;  If either are #false, return #false
;  If both are not #false and match, return the same Char
;  If neither match, return #false
(define (compare-char c1 c2)
  (cond
    [(or (false? c1) (false? c2)) #false]
    [(string=? c1 c2) c1]
    [else #false]))


; Word Word -> Word
; Create a new Word by comparing two Words using the following rules...
; For a given Char position in each Word:
;  if either Char are #false, new Char is #false
;  if both Chars match, new Char is the same as
;  if neither match, new Char is #false
(check-expect
 (compare-word (make-word "a" "b" "c") (make-word "a" "b" "c"))
 (make-word "a" "b" "c"))
(check-expect
 (compare-word (make-word #false "b" "d") (make-word "a" "b" "c"))
 (make-word #false "b" #false))
(check-expect
 (compare-word (make-word #false "b" "c") (make-word #false "b" "c"))
 (make-word #false "b" "c"))
(define (compare-word w1 w2)
  (make-word (compare-char (word-c1 w1) (word-c1 w2))
             (compare-char (word-c2 w1) (word-c2 w2))
             (compare-char (word-c3 w1) (word-c3 w2))))

