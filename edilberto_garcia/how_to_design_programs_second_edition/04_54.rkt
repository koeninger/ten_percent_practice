;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 04_54) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 54. Why is (string=? "resting" x) incorrect as the first
;    condition in show? Conversely, formulate a completely accurate
;    condition, that is, a Boolean expression that evaluates to #true
;    precisely when x belongs to the first sub-class of LRCD.


(define (show x)
  (cond
    [(string? x) ...]
    [(<= -3 x -1) ...]
    [(>= x 0) ...]))


; You're passing in the variable HEIGHT to show which is a number not a
;    string


