;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |82|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; letter is one of
; 1String [a,z]
; #false
; lower case letters [a,z] or no letter

(define l1 "a")
(define l2 "k")
(define l3 #false)

;template
(define (fn-for-letter l)
  (cond [(and (string? l) (string<=? "a" l "z")) ...]
        [(equal? #false l) ...]))


(define-struct word [lt1 lt2 lt3])
; word is a (make-word letter letter letter)
; interp.  word consists of 3 lower case letters

(define word1 (make-word "y" "e" "s"))
(define word2 (make-word "h" "e" "y"))
(define word3 (make-word "n" "o" #false))


; compare letter
(check-expect (compare-letter "a" "a") "a")
(check-expect (compare-letter "a" "b") #false)
(check-expect (compare-letter "a" #false) #false)

; check both letters are strings and if they are equal
(define (compare-letter l1 l2)
  (cond [(and (string? l1) (string<=? "a" l1 "z")
              (string? l2) (string<=? "a" l2 "z"))
         (cond [(string=? l1 l2) l1]
               [else #false])] 
[else #false]))


; word
(define (fn-for-word w)
  (... (... (word-lt1 w))
       (... (word-lt2 w))
       (... (word-lt3 w))))


(check-expect (compare-word (make-word "y" "e" "s") (make-word "y" "e" "s"))
              (make-word "y" "e" "s"))
(check-expect (compare-word (make-word "y" "e" "s") (make-word "l" "e" "s"))
              (make-word #false "e" "s"))

(define (compare-word w1 w2 )
  (make-word (compare-letter (word-lt1 w1) (word-lt1 w2))
             (compare-letter (word-lt2 w1) (word-lt2 w2))
             (compare-letter (word-lt3 w1) (word-lt3 w2))
  )
)