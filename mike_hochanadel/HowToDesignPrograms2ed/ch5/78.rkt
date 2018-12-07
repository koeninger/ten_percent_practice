;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |78|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct three-letter-word [first second third])
; three-letter-word is one of:
; - (make-three-letter-word [1String->[a-z] 1String->[a-z] 1String->[a-z]])
; - or $false

; alhtough I interpret this as this too:

(define-struct three-letter-word2 [String])
; three-letter-word is one of:
; - String consisting of 1Strings in [a-z]
; - or #false