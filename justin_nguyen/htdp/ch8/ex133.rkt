;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex133) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; List-of-names -> Boolean
; determines whether "Flatt" occurs on alon
(check-expect
  (contains-flatt? (cons "X" (cons "Y"  (cons "Z" '()))))
  #false)
(check-expect
  (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '()))))
  #true)
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) "Flatt")
         (contains-flatt? (rest alon)))]))

;(cond
;      [(string=? (first alon) "Flatt") #true]
;      [else (contains-flatt? (rest alon))])

; produces same answer because it checks the same conditions and returns the same
; values and executes the same code based on those conditions