;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 195|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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

; (starts-with# "e" AS-LIST)
; 7818

; (starts-with# "z" AS-LIST)
; 719