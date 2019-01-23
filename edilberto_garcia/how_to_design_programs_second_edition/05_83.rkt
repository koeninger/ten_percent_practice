;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_83) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 83. Design the function render, which consumes an Editor and produces an image.



; The purpose of the function is to render the text within an empty scene of 200x20 image pixels.
;    For the cursor, use a 1x20 image red rectangle and for the strings, black text of size 16.


(require 2htdp/image)
(require 2htdp/universe)


(define cursor (rectangle 1 20 "solid" "red"))
(define background (empty-scene 200 20))




(
    define (render txt)
    (
        overlay/align "left" "center"
        (beside (text (editor-pre txt) 11 "black") cursor (text (editor-post txt) 11 "black"))
        background
    )
        
)



; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(define-struct editor [pre post])

