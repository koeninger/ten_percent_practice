;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_84) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 84. Design edit. The function consumes two inputs, an editor ed and a KeyEvent ke, and it produces another editor. Its task is to add a single-character KeyEvent ke to the end of the pre field of ed, unless ke denotes the backspace ("\b") key. In that case, it deletes the character immediately to the left of the cursor (if there are any). The function ignores the tab key ("\t") and the return key ("\r").

;The function pays attention to only two KeyEvents longer than one letter: "left" and "right". The left arrow moves the cursor one character to the left (if any), and the right arrow moves it one character to the right (if any). All other such KeyEvents are ignored.

;Develop a goodly number of examples for edit, paying attention to special cases. When we solved this exercise, we created 20 examples and turned all of them into tests.

;Hint Think of this function as consuming KeyEvents, a collection that is specified as an enumeration. It uses auxiliary functions to deal with the Editor structure. Keep a wish list handy; you will need to design additional functions for most of these auxiliary functions, such as string-first, string-rest, string-last, and string-remove-last. If you haven’t done so, solve the exercises in Functions.




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




(define (edit editor_object ke)

 )