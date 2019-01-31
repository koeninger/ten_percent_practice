;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_85) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 85. Define the function run. Given the pre field of an editor, it launches an interactive editor, using render and edit from the preceding two exercises for the to-draw and on-key clauses, respectively.


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



; Editor KeyEvent -> Editor
; Adds a character after  pre-text
; If key is delete key then it deletes last character
(check-expect (edit (make-editor "Starfleetz" "Headquarters") "\b") (make-editor "Starfleet" "Headquarters"))
(check-expect (edit (make-editor "Gamm" "Quadrant") "a") (make-editor "Gamma" "Quadrant"))
(define (edit editor_object ke)
(make-editor

   (cond
    [(string=? "\b" ke) (substring (editor-pre editor_object) 0 (- (string-length (editor-pre editor_object)) 1))  ]
    [else (string-append (editor-pre editor_object) ke)]
   )

   (editor-post editor_object))
 

)


(define (to-draw) ...)
(define (on-key)  ...)
