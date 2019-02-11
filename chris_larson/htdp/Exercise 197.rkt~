;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 197|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; On OS X: 
(define LOCATION "/usr/share/dict/words")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; A Letter Count is a Letter and an Integer
; c is the number of times l appears in a Dictionary
(define-struct letter-count [letter count])

; Letter Dictionary -> Integer
; Counts the number of words in the dictionary
; that start with the letter
(define (starts-with# l d)
  (cond
    [(empty? d) 0]
    [else (if (string=? l (first (explode (first d))))
              (+ 1 (starts-with# l (rest d))) (starts-with# l (rest d)))]))

(check-expect (starts-with# "e" (list "hello" "world" "how" "is" "every" "thing")) 1)
(check-expect (starts-with# "e" (list "hello" "world" "how" "is" "every" "thing" "earn")) 2)
(check-expect (starts-with# "e" (list "hello" "world" "how" "is" "a" "thing")) 0)

; Dictionary -> List-of-Letter-Counts
(define (count-by-letter d)
  (count-by-letters LETTERS d))

; List-of-Letters Dictionary -> List-of-Letter-Counts
(define (count-by-letters l d)
  (cond
    [(empty? l) '()]
    [else (cons (make-letter-count (first l) (starts-with# (first l) d)) (count-by-letters (rest l) d))]))
(check-expect (count-by-letters (list "a" "b" "h") (list "hello" "world" "how" "is" "every" "thing")) (list (make-letter-count "a" 0) (make-letter-count "b" 0) (make-letter-count "h" 2)))

; Dictionary -> Letter-Count
; leter that occurs most often
(define (most-frequent d)
  (highest-count (count-by-letters LETTERS d) (make-letter-count "" 0)))

(define (highest-count l h)
  (cond
    [(empty? l) h]
    [else (if (> (letter-count-count (first l)) (letter-count-count h)) (highest-count (rest l) (first l)) (highest-count (rest l) h))]))
(check-expect (highest-count (list (make-letter-count "a" 0) (make-letter-count "b" 0) (make-letter-count "h" 2)) (make-letter-count "" 0)) (make-letter-count "h" 2))
(check-expect (highest-count (list (make-letter-count "a" 5) (make-letter-count "b" 0) (make-letter-count "h" 2)) (make-letter-count "" 0)) (make-letter-count "a" 5))