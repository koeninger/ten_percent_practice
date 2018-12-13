;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |82|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; used this version where I had 2 definitions
(define-struct three-letter-word [first second third])
; three-letter-word is one of:
; - (make-three-letter-word [1String->[a-z] 1String->[a-z] 1String->[a-z]])
; - or #false

; 1String, 1String -> 1String, boolean
; compare-letter returns the given 1Strings character if equal, #false if not
(check-expect (compare-letter "a" "a") "a")
(check-expect (compare-letter "a" "b") #false)
(define (compare-letter letter1 letter2)
  (if (equal? letter1 letter2) letter1 #false))

; three-letter-word, three-letter-word -> three-letter-word
; compare-word reports the comparison outcomes of each respective
;  letter as three-letter-word, giving false where the letters don't
;  match
(check-expect (compare-word
               (make-three-letter-word "a" "b" "c")
               (make-three-letter-word "a" "b" "c"))
              (make-three-letter-word "a" "b" "c"))
(check-expect (compare-word
               (make-three-letter-word "a" "b" "c")
               (make-three-letter-word "b" "b" "c"))
              (make-three-letter-word #false "b" "c"))
(check-expect (compare-word
               (make-three-letter-word "a" "b" "c")
               (make-three-letter-word "c" "a" "c"))
              (make-three-letter-word #false #false "c"))
(check-expect (compare-word
               (make-three-letter-word "a" "b" "c")
               (make-three-letter-word "c" "a" "b"))
              (make-three-letter-word #false #false #false))
(define (compare-word word1 word2)
  (make-three-letter-word
     (compare-letter (three-letter-word-first word1) (three-letter-word-first word2))
     (compare-letter (three-letter-word-second word1) (three-letter-word-second word2))
     (compare-letter (three-letter-word-third word1) (three-letter-word-third word2))))