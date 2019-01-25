;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |109|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

(define WIDTH 200)
(define HEIGHT 200)

(define COLOR1 "white")
(define COLOR2 "yellow")
(define COLOR3 "green")
(define COLORX "red")
	
; ExpectsToSee.v2 is one of:
; – AA
; – BB
; – DD 
; – ER 

(define AA "start, ...")
(define BB "expect ...")
(define DD "finished")
(define ER "error, ...")

