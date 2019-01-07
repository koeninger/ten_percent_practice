;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 12.3_word_games) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/batch-io)
; On OS X: 
(define DICT-LOCATION "/usr/share/dict/words")

(define DICT (read-lines DICT-LOCATION))

; 209

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; String -> Word
; converts s to the chosen word representation
(check-expect (string->word "bob") (list "b" "o" "b"))
(define (string->word s)
  (cond
    [(string=? s "") '()]
    [else (cons (substring s 0 1)
                (string->word (substring s 1)))]))

 
; Word -> String
; converts w to a string
(check-expect (word->string (list "b" "o" "b")) "bob")
(define (word->string w)
  (cond
    [(empty? w) ""]
    [(cons? w)
     (string-append (first w) (word->string (rest w)))]))

; 210

; List-of-words -> List-of-strings
; turns all Words in low into Strings
(check-expect (words->strings (list (list "b" "o" "b") (list "t" "e" "d")))
              (list "bob" "ted"))
(define (words->strings low)
  (cond
    [(empty? low) '()]
    [(cons? low)
     (cons (word->string (first low)) (words->strings (rest low)))]))

; 211


; List-of-strings -> List-of-strings
; picks out all those Strings that occur in the dictionary
(check-expect (in-dictionary (list "biscuit" "asasa" "cake"))
              (list "biscuit" "cake"))
(define (in-dictionary los)
  (cond
    [(empty? los) '()]
    [(cons? los)
     (if (member? (first los) DICT)
         (cons (first los) (in-dictionary (rest los)))
         (in-dictionary (rest los)))]))

; 212

; a list-of-words is one of
; '() or
; (cons word list-of-words)

(define example-word (list "a" "b"))
(define example-list-of-words (list example-word (list "c" "d")))

(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words (first w)
            (arrangements (rest w)))]))

; 1string list-of-words -> list-of-words
; first argument inserted at the beginning, between all letters, and at the end of all words of the given list.
(check-expect (insert-everywhere/in-all-words "a" '())
              '())
(check-expect (insert-everywhere/in-all-words "a" (list '()))
              (list (list "a")))
(check-expect (insert-everywhere/in-all-words "a" (list (list "e")))
              (list (list "a" "e") (list "e" "a")))
(check-expect (insert-everywhere/in-all-words "a" (list (list "e" "r") (list "r" "e")))
              (list (list "a" "e" "r") (list "e" "a" "r") (list "e" "r" "a")
                    (list "a" "r" "e") (list "r" "a" "e") (list "r" "e" "a")))
(define (insert-everywhere/in-all-words c ws)
  (cond
    [(empty? ws) '()]
    [(cons? ws) (append (insert-everywhere c (first ws)) (insert-everywhere/in-all-words c (rest ws)))]))
; 1string word -> list-of-words
; first argument inserted at the beginning, between all letters, and at the end of given word
(check-expect (insert-everywhere "a" '())
              (list (list "a")))
(check-expect (insert-everywhere "a" (list "r"))
              (list (list "a" "r") (list "r" "a")))
(check-expect (insert-everywhere "a" (list "e" "r"))
              (list (list "a" "e" "r") (list "e" "a" "r") (list "e" "r" "a")))
(define (insert-everywhere c w)
  (cond
    [(empty? w) (list (list c))]
    [(cons? w) (cons (cons c w)
                     (insert-first (first w) (insert-everywhere c (rest w))))]))
;1string list-of-words -> list-of-words
; add c to head of each word
(define (insert-first c ws)
  (cond
    [(empty? ws) '()]
    [(cons? ws) (cons (cons c (first ws))
                      (insert-first c (rest ws)))]))