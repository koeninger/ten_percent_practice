;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex134) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String List-of-strings -> Boolean
; determines whether a string occurs in list of strings
(check-expect
 (contains? "X" (cons "X" (cons "Y"  (cons "Z" '()))))
 #true)
(check-expect
 (contains? "Y" (cons "X" (cons "Y"  (cons "Z" '()))))
 #true)
(check-expect
 (contains? "Z" (cons "X" (cons "Y"  (cons "Z" '()))))
 #true)
(check-expect
 (contains? "A" (cons "X" (cons "Y"  (cons "Z" '()))))
 #false)
(define (contains? s l)
  (cond
    [(empty? l) #false]
    [(cons? l)
     (or (string=? (first l) s)
         (contains? s (rest l)))]))