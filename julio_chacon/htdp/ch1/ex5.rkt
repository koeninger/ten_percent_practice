;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
 (require 2htdp/image)
(define myscale 1)

(define mytree (overlay/xy (circle 30 "solid" "green")
          15 50
           (rectangle 30 60 "solid" "brown") ))

	
(define sizeTree (scale myscale mytree))