;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex35) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String -> String
; get last char of str
; given "hello", expect: "o"
; given "bye", expect: "e"
(define (string-last str)
  (string-ith str (- (string-length str) 1)))

(string-last "hello")
(string-last "bye")