;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex37) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
; string -> string
; returns string minus first charachter
; take a str and remove first char
; given: "test", expect: "est"
; given: "home", expect: "ome"
(define (string-rest str)
  ( substring str 1 (string-length str) ) )

