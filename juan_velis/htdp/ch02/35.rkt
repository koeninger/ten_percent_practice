;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |35|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String -> String
; Extracts the last character of a given string
; given "hello", expect "o"
(define (string-last s)
  (substring s
             (- (string-length s) 1)
             (string-length s)
  )
)

(string-last "hello")