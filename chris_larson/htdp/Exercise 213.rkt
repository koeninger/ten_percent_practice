;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 213|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; On OS X: 
(define LOCATION "/usr/share/dict/words")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; A List-of-words is onde of:
; - '() or
; - (cons Word List-of-words)
 
; Word -> List-of-words
; finds all rearrangements of word
(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words (first w)
            (arrangements (rest w)))]))
(check-expect (arrangements (list "d" "e")) (list (list "d" "e") (list "e" "d")))

; 1String List-of-words -> List-of-words
; 1String is added to beginning of each word
(define (insert-everywhere/in-all-words s low)
  (cond
    [(empty? low) '()]
    [else (append (insert-everywhere s '() (first low)) (insert-everywhere/in-all-words s (rest low)))]))
(check-expect (insert-everywhere/in-all-words "d" (list (list"e"))) (list (list "d" "e") (list "e" "d")))

; 1String Word -> List-of-words
; puts one string in each position
(define (insert-everywhere s a p)
  (cond
    [(empty? p) (cons (insert-1string s a p) '())]
    [else (cons (insert-1string s a p) (insert-everywhere s (append a (list (first p))) (rest p)))]))
(check-expect (insert-everywhere "a" '() (list "e")) (list (list "a" "e") (list "e" "a")))

; 1String Word Word -> Word
; inserts 1String between words
(define (insert-1string s a p)
  (append a (list s) p))
(check-expect (insert-1string "a" (list "b" "c") (list "d" "e")) (list "b" "c" "a" "d" "e"))

; List-of-strings -> Boolean
(define (all-words-from-rat? w)
  (and
    (member? "rat" w) (member? "art" w) (member? "tar" w)))
(define (all-words-from-fold? w)
  (and
   (member? "fold" w) (member? "old" w)))
 
; String -> List-of-strings
; finds all words that the letters of some given word spell
 
(check-member-of (alternative-words "cat")
                 (list "act" "cat")
                 (list "cat" "act"))
 
(check-satisfied (alternative-words "rat")
                 all-words-from-rat?)

; String -> Word
; converts s to the chosen word representation 
(define (string->word s) (explode s))
(check-expect (string->word "hat") (list "h" "a" "t"))

; Word -> String
; converts w to a string
(define (word->string w) (implode w))
(check-expect (word->string (list "h" "a" "t")) "hat")

(define (alternative-words s)
  (in-dictionary
    (words->strings (arrangements (string->word s)))))
 
; List-of-words -> List-of-strings
; turns all Words in low into Strings 
(define (words->strings low)
  (cond
    [(empty? low) '()]
    [else (cons (word->string (first low)) (words->strings (rest low)))]))
(check-expect (words->strings (list (list "h" "a" "t"))) (list "hat"))

; List-of-strings -> List-of-strings
; picks out all those Strings that occur in the dictionary
(define (in-dictionary los)
  (strings-in-dictionary los AS-LIST))

(define (strings-in-dictionary los d)
  (cond
    [(empty? los) '()]
    [else (if (member? (first los) d) (cons (first los) (in-dictionary (rest los))) (in-dictionary (rest los)))]))
