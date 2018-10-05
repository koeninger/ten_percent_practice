;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex38) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
; string -> string
; returns string minus last charachter
; take a str and remove last char
; given: "test", expect: "tes"
; given: "home", expect: "hom"
(define (string-remove-last str)
  ( substring str 0 (- (string-length str) 1 ) )
)
