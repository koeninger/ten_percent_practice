;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex117) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;(3 + 4)
; this has a grammar: (expr variable expr). no such grammar exists where an open parenthesis can be
; followed by an expr

;number?
; number? is a function, so it must used with an open parenthesis before the function

;(x)
; there is no grammar for an expression using parentheses with only a single element