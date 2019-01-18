;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_83) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 83. Design the function render, which consumes an Editor and produces an image.


(overlay/align "left" "center"
               (text "hello world" 11 "black")
               (empty-scene 200 20))


(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t
