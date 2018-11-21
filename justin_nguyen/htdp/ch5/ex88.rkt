;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex88) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


; a VCat is a Cat strucutre

; a Cat is a structure:
;  (make-cat Number Number)
;  interpretation pos represents x-coordinate of cat on screen,
;  happy represents happiness level of cat

(define-struct VCat [pos happy])