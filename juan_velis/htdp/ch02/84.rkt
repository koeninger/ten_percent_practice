;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |84|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t
(define editor1 (make-editor "hello" "world"))

; Render the editor
; Editor -> Image
(define (render e)  
   (overlay/align "left" "center"
                  (beside (text (editor-pre editor1) 16 "black")
                          (rectangle 1 20 "solid" "red")
                          (text (editor-post editor1) 16 "black"))
                  (empty-scene 200 20))
   )
(check-expect (render editor1)
              (overlay/align "left" "center"
                  (beside (text (editor-pre editor1) 16 "black")
                          (rectangle 1 20 "solid" "red")
                          (text (editor-post editor1) 16 "black"))
                  (empty-scene 200 20)))
;(render editor1)

; Backspace
; Editor -> Editor
; Remove the character to the left of the cursor
(define (backspace ed)
  (cond
    [(> (string-length (editor-pre ed)) 0)
     (make-editor
      (substring (editor-pre ed) 0 (- (string-length (editor-pre ed)) 1)) ; string-last
      (editor-post ed))]
    [else ed]
   )
)
(check-expect (backspace editor1) (make-editor "hell" "world"))
(check-expect (backspace (make-editor "ab" "cd")) (make-editor "a" "cd"))
(check-expect (backspace (make-editor "" "world")) (make-editor "" "world"))

; string-last
; get the last character of a string
(define (string-last s)
  (substring s 0 (- (string-length s) 1))
)

; string-first
; get the first character of a string
;(define (string-first s)
;  (substring s 0 (- (string-length s) 1))
;)


; Edit
; Editor, KeyEvent -> Editor
; Adds a character (0-1,a-z) ke to the end of the pre field of ed
; If backspace, removes a character to the left
(define (edit ed ke)
  (cond
    [(and (= (string-length ke) 1) (or (string<=? "a" ke "z") (string<=? "0" ke "9")))
     (make-editor (string-append (editor-pre ed) ke) (editor-post ed))]
    [(string=? "\b" ke) (backspace ed)]
    ;[(string=? "left" ke) ...]
    ;[(string=? "right" ke) ...]    
    [else ed]
    )
)
(check-expect (edit editor1 "a")
              (make-editor (string-append "hello" "a") (editor-post editor1)))
(check-expect (edit editor1 "x")
              (make-editor (string-append (editor-pre editor1) "x") (editor-post editor1)))
(check-expect (edit editor1 "1")
              (make-editor (string-append (editor-pre editor1) "1") (editor-post editor1)))
(check-expect (edit editor1 "9")
              (make-editor (string-append (editor-pre editor1) "9") (editor-post editor1)))