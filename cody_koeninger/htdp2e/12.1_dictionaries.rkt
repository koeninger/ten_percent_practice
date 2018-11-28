;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12.1_dictionaries) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/batch-io)
; On OS X: 
(define LOCATION "/usr/share/dict/words")

(define AS-LIST (read-lines LOCATION))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; Letter Dictionary -> Non-NegativeNumber
; count the number of words in dictionary that start with letter
(check-expect (starts-with# "a" (list "0x" "apple" "abracadabra" "bandana" "cat")) 2)
(define (starts-with# c d)
  (cond
    [(empty? d) 0]
    [(cons? d) (+ (if (string=? c (string-ith (first d) 0)) 1 0)
                  (starts-with# c (rest d)))]))