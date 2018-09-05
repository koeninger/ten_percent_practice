;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |37|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String -> String
; Removes the first character of a given string
; given "hello", expect "ello"
(define (string-rest s)
  (substring s
             1 (string-length s)
  )
)

(string-rest "hello")