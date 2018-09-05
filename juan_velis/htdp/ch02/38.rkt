;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |38|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; String -> String
; Removes the last character of a given string
; given "morning", expect "mornin"
(define (string-remove-last s)
  (substring s
             0
             (- (string-length s) 1)
  )
)

(string-remove-last "morning")