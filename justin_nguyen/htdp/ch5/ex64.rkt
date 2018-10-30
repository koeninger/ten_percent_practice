;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex64) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; it doesn't matter which strategy we use for manhattan walk.


(define (manhattan-distance p) (+ (abs (posn-x p)) (abs (posn-y p))))