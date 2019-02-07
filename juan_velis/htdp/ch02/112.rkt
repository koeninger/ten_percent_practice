;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |112|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Any -> Boolean
(define (missile-or-not? v)
  (or (false? v) (posn? v))
)
(check-expect (missile-or-not? #true) #false)
(check-expect (missile-or-not? #false) #true)
(check-expect (missile-or-not? "text") #false)
(check-expect (missile-or-not? 1) #false)

