;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex38) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; We use strings to represent words.
; String -> String
; Return x with the last 1String removed
; given: "Hi", expect: "H"
; given: "World", expect: "Worl"
(define (string-remove-last x)
  (substring x 0 (string-length x)))

(string-remove-last "Worl")