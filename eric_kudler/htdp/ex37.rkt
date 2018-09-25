;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex37) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; We use strings to represent words.
; String -> String
; Return x with the first 1String removed
; given: "Hello", expect: "ello"
; given: "World", expect: "orld"
(define (string-reset x)
  (substring x 1 (string-length x)))

(string-reset "Hello")