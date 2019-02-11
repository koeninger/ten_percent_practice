;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 05_87) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 87. Develop a data representation for an editor based on our first idea, using a string and an index. Then solve the preceding exercises again. Retrace the design recipe. Hint if you haven’t done so, solve the exercises in Functions.




(require 2htdp/image)
(require 2htdp/universe)


(define cursor (rectangle 1 20 "solid" "red"))
(define background (empty-scene 200 20))

(
    define (render txt)
    (
        overlay/align "left" "center"

        ;break up the editor text by the string index then place the cursor between
        (beside (text (editor-pre txt) 11 "black") cursor (text (editor-post txt) 11 "black"))
        background
    )
        
)


; An Editor is a structure:
;   (make-editor String Integer)
; interpretation (make-editor s i) describes an editor
; whose visible text is s with 
; the cursor displayed between at i
(define-struct editor [str index])



; Editor KeyEvent -> Editor
; Adds a character after  pre-text
; If key is delete key then it deletes last character
(check-expect (edit (make-editor "Starfleetz" "Headquarters") "\b") (make-editor "Starfleet" "Headquarters"))
(check-expect (edit (make-editor "Gamm" "Quadrant") "a") (make-editor "Gamma" "Quadrant"))
(check-expect (edit
     (make-editor "Really long sentence really long sentence really long sentence" "really long sentence") "X")
     (make-editor "Really long sentence really long sentence really long sentence" "really long sentence")
)
(define (edit editor_object ke)
(make-editor

   (cond
    [(and (string? ke) (equal? (string-length ke) 1) ( > (image-width (render editor_object)) 200)) (editor-pre editor_object)]
    [(string=? "\b" ke) (substring (editor-pre editor_object) 0 (- (string-length (editor-pre editor_object)) 1))  ]
    [else (string-append (editor-pre editor_object) ke)]
   )

   (editor-post editor_object))
 

)

(define (run editor-instance)
  (big-bang editor-instance
    [to-draw render]
    [on-key edit]))
