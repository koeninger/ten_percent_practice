;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex82) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A Word is a three letter word:
;  (make-word char char char)
; Char can any of the following:
;  any 1String from "a" through "z"
;  #false
(define-struct word [char1 char2 char3])

; Char Char -> Char
; Compares two Chars.
;  If either are #false, return #false
;  If neither are not #false and they match, return the same Char
;  If neither match, return #false
(define (compare-char char1 char2)
  (cond
    [(or (false? char1) (false? char2)) #false]
    [(string=? char1 char2) char1]
    [else #false]))


; Word Word -> Word
; Create a new Word by comparing two Words using the following rules...
; For a given Char position in each Word:
;  if either Char are #false, new Char is #false
;  if both Chars match, new Char is the same as
;  if neither match, new Char is #false
(define (compare-word w1 w2)
  (make-word (compare-char (word-char1 w1) (word-char1 w2))
             (compare-char (word-char2 w1) (word-char2 w2))
             (compare-char (word-char3 w1) (word-char3 w2))))

(check-expect
 (compare-word (make-word "a" "b" "c") (make-word "a" "b" "c"))
 (make-word "a" "b" "c"))

(check-expect
 (compare-word (make-word #false "b" "c") (make-word #false "b" "c"))
 (make-word #false "b" "c"))

(check-expect
 (compare-word (make-word #false "b" "d") (make-word "a" "b" "c"))
 (make-word #false "b" #false))