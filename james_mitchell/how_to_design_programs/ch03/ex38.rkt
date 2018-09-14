;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex38) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; String -> !String
; Given a string, remove the last character
; Given: "h"            expected: ""
; Given: "hello world"  expected: "hello worl"
; Given 42              expected: not a string
; (define (string-remove-last string) ... )

(define (string-remove-last string)
  (if (string? string)
      (substring string 0 (- (string-length string) 1))
   "Not an string"))

  