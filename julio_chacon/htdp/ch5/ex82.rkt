;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex82) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; a Word is a 3 letter word.
(define-struct word [l1 l2 l3])


(define TEST-WORD1 (make-word "r" "u" "n"))
(define TEST-WORD2 (make-word "p" "u" "n"))


;
;(check-expect (compare-word (make-3letterWords "run") (make-3letterWords "pun")) 45002)  
(define (compare-word w1 w2)
  (cond
    [(boolean? (compare-letters (word-l1 w1) (word-l1 w2)) ) #false]
    [(boolean? (compare-letters (word-l2 w1) (word-l2 w2)) ) #false]
    [(boolean? (compare-letters (word-l3 w1) (word-l3 w2)) ) #false]
    [else (string-append (word-l1 w1) (word-l2 w1) (word-l3 w1))]
    ))


(define (compare-letters l1 l2)
 (cond
    [(or (not (string? l1) ) (not (string? l2)) ) #false]
    [(string=? l1 l2) l1]
    [else #false]))

(check-expect (compare-word TEST-WORD1 TEST-WORD2) #false)




