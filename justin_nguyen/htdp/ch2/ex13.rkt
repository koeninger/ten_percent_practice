;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (string-first input) (if (> (string-length input) 0) (string-ith input 0) "Warning: empty string input"))

(string-first "hi")
(string-first "cat")
(string-first "")