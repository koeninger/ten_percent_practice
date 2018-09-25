;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex35) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; We use strings to represent words.
; String -> 1String
; Return the last character of x
; given: "Hello", expect: "o"
; given: "World", expect: "d"
(define (string-last x)
  (substring x (- (string-length x) 1) (string-length x)))

(string-last "Hello")