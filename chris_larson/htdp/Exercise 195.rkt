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

; A Letter Count is a Letter and an Integer
; c is the number of times l appears in a Dictionary
(define-struct letter-count [letter count])

(define LETTER-LIST (cons
 (make-letter-count "a" 0)
 (cons
  (make-letter-count "b" 0)
  (cons
   (make-letter-count "c" 0)
   (cons
    (make-letter-count "d" 0)
    (cons
     (make-letter-count "e" 0)
     (cons
      (make-letter-count "f" 0)
      (cons
       (make-letter-count "g" 0)
       (cons
        (make-letter-count "h" 0)
        (cons
         (make-letter-count "i" 0)
         (cons
          (make-letter-count "j" 0)
          (cons
           (make-letter-count "k" 0)
           (cons
            (make-letter-count "l" 0)
            (cons
             (make-letter-count "m" 0)
             (cons
              (make-letter-count "n" 0)
              (cons
               (make-letter-count "o" 0)
               (cons
                (make-letter-count "p" 0)
                (cons
                 (make-letter-count "q" 0)
                 (cons (make-letter-count "r" 0) (cons (make-letter-count "s" 0) (cons (make-letter-count "t" 0) (cons (make-letter-count "u" 0) (cons (make-letter-count "v" 0) (cons (make-letter-count "w" 0) (cons (make-letter-count "x" 0) (cons (make-letter-count "y" 0) (cons (make-letter-count "z" 0) '())))))))))))))))))))))))))))

; solution
(define COUNTS (cons
 (make-letter-count "a" 14537)
 (cons
  (make-letter-count "b" 9675)
  (cons
   (make-letter-count "c" 17406)
   (cons
    (make-letter-count "d" 9946)
    (cons
     (make-letter-count "e" 7818)
     (cons
      (make-letter-count "f" 6382)
      (cons
       (make-letter-count "g" 5843)
       (cons
        (make-letter-count "h" 7889)
        (cons
         (make-letter-count "i" 8303)
         (cons
          (make-letter-count "j" 1158)
          (cons
           (make-letter-count "k" 1735)
           (cons
            (make-letter-count "l" 5211)
            (cons
             (make-letter-count "m" 10709)
             (cons
              (make-letter-count "n" 6098)
              (cons
               (make-letter-count "o" 7219)
               (cons
                (make-letter-count "p" 22171)
                (cons
                 (make-letter-count "q" 1075)
                 (cons (make-letter-count "r" 8955) (cons (make-letter-count "s" 22759) (cons (make-letter-count "t" 11389) (cons (make-letter-count "u" 16179) (cons (make-letter-count "v" 3079) (cons (make-letter-count "w" 3607) (cons (make-letter-count "x" 293) (cons (make-letter-count "y" 532) (cons (make-letter-count "z" 719) '())))))))))))))))))))))))))))

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

; Dictionary -> List-of-Letter-Counts
(define (count-by-letter d)
  (count-by-letters LETTERS d))

; List-of-Letters Dictionary -> List-of-Letter-Counts
(define (count-by-letters l d)
  (cond
    [(empty? l) '()]
    [else (cons (make-letter-count (first l) (starts-with# (first l) d)) (count-by-letters (rest l) d))]))
(check-expect (count-by-letters (list "a" "b" "h") (list "hello" "world" "how" "is" "every" "thing")) (list (make-letter-count "a" 0) (make-letter-count "b" 0) (make-letter-count "h" 2)))

; (count-by-letter AS-LIST)

(define (count-letters l d)
  (cond
    [(empty? d) l]
    [else (count-letters (add-to-letters (first (explode (first d))) l) (rest d))]))
(check-expect (count-letters (list (make-letter-count "a" 0) (make-letter-count "b" 0) (make-letter-count "h" 0)) (list "hello" "world" "how" "is" "every" "thing")) (list (make-letter-count "a" 0) (make-letter-count "b" 0) (make-letter-count "h" 2)))

(define (add-to-letters s l)
  (cond
    [(empty? l) '()]
    [else (cons (if (string=? s (letter-count-letter (first l)) s) (make-letter-count s (+ 1 (letter-count-count (first l)))) (first l)) (add-to-letters s (rest l)))]))

(check-expect (add-to-letters "a" (list (make-letter-count "a" 0) (make-letter-count "b" 0) (make-letter-count "h" 0))) (list (make-letter-count "a" 1) (make-letter-count "b" 0) (make-letter-count "h" 0)))
;(check-expect (count-letters LETTER-LIST AS-LIST) COUNTS)




          