;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 01_07) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define sunny #true)
(define friday #false)

;Now create an expression that computes whether sunny is false or friday is true.
;So in this particular case, the answer is #false. (Why?) => false OR false  is false

(or (not sunny) friday)