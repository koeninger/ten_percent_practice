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

;ex 196
; letter and count
(define-struct letter-count [letter count])
(define (letter c) (letter-count-letter c))
(define (count c) (letter-count-count c))

; dictionary -> list of letter-count
; how often each letter is used as first in word in dictionary
(check-expect (count-by-letter (list "apple" "abracadabra" "bob"))
              (list (make-letter-count "a" 2) (make-letter-count "b" 1)))
(define (count-by-letter d)
  (cond
    [(empty? d) '()]
    [(cons? d)
     (merge-letter-counts (make-letter-count (string-ith (first d) 0) 1)
                          (count-by-letter (rest d)))]))

; letter-count list-of-letter-count -> list-of-letter-count
; adds letter-count to the list, assumes dictionary words are in order
(check-expect (merge-letter-counts (make-letter-count "b" 1) (list (make-letter-count "b" 2) (make-letter-count "a" 3)))
              (list (make-letter-count "b" 3) (make-letter-count "a" 3)))
(check-expect (merge-letter-counts (make-letter-count "b" 1) '())
              (list (make-letter-count "b" 1)))
(define (merge-letter-counts c cs)
  (cond
    [(empty? cs) (list c)]
    [(cons? cs)
     (if (string=? (letter c) (letter (first cs)))
         (cons (make-letter-count (letter c) (+ (count c) (count (first cs))))
               (rest cs))
         (cons c cs))]))

; ex 197

; dictionary -> string
; letter count for letter that occurs most often as the first one in a word
(check-expect (most-frequent (list "apple" "abracadabra" "bob"))
              "a")
(define (most-frequent d)
  (letter (max-by-count* (count-by-letter d))))

; list-of-letter-count -> letter-count
; letter with maximum count
(check-expect (max-by-count* (list (make-letter-count "b" 1) (make-letter-count "a" 2) (make-letter-count "c" 1))) (make-letter-count "a" 2))
(define (max-by-count* cs)
  (cond
    [(empty? cs) (error 'max-by-count "no maximum for empty list")]
    [(empty? (rest cs)) (first cs)]
    [(cons? cs) (max-by-count (first cs) (max-by-count* (rest cs)))]
    ))

; really would like to have local variables by now...
(define (max-by-count a b)
  (if (> (count a) (count b)) a b))

; ex 198

; dictionary -> list of dictionary
; one dictionary per letter in input dictionary
(check-expect (words-by-first-letter (list "a" "aa" "b" "bb"))
              (list (list "a" "aa") (list "b" "bb")))
(define (words-by-first-letter d)
  (cond
    [(empty? d) '()]
    [(empty? (rest d)) (list (list (first d)))]
    [(cons? d)
     ; for the love of god, local variables...
     (if (string=? (string-ith (first d) 0) (string-ith (first (first (words-by-first-letter (rest d)))) 0))
         (cons (cons (first d) (first (words-by-first-letter (rest d)))) (rest (words-by-first-letter (rest d))))
         (cons (list (first d)) (words-by-first-letter (rest d))))]))

; see most-frequent
(check-expect (most-frequent (list "a" "aa" "b" "c")) (most-frequent.v2 (list "a" "aa" "b" "c")))
(define (most-frequent.v2 d)
  (letter (max-by-count* (count-by-letter.v2 (words-by-first-letter d)))))

; list of dictionary -> list of letter count
(define (count-by-letter.v2 ld)
  (cond
    [(empty? ld) '()]
    [(cons? ld)
     (cons (make-letter-count (string-ith (first (first ld)) 0) (length (first ld)))
           (count-by-letter.v2 (rest ld)))]))