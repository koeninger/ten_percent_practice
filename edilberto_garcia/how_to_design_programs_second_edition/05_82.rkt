;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_82) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 82. Design the function compare-word. The function consumes two
;    three-letter words (see exercise 78). It produces a word that indicates
;    where the given ones agree and disagree. The function retains the content
;    of the structure fields if the two agree; otherwise it places #false in the
;    field of the resulting word. Hint The exercises mentions two tasks: the comparison
;    of words and the comparison of “letters.”




; A three-letter-word is one of
; - a series of three 1Strings "a" through "z"
; - #false
(define-struct three-letter-word [letter1 letter2 letter3])



(define (compare-word word1 word2)

  (implode (list (three-letter-word-letter1 word1) (three-letter-word-letter2 word1) (three-letter-word-letter3 word1)))

 ; (implode (list (three-letter-word-letter1 word2) (three-letter-word-letter2 word2) (three-letter-word-letter3 word2)))

  
)

(define (compare-letter letter1 letter2)
(char=? (list letter1 letter2))
 )