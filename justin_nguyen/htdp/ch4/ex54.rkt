;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex54) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; it is incorrect because it assumes the input is a string; we can potentially pass in ints as x.

(define (show x)
  (cond
    [(if (string? x) (string=? "resting" x) #false) ...]
    [(<= -3 x -1) ...]
    [(>= x 0) ...]))


