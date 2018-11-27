;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |87|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


(define-struct editor [string index])
; editor is an structure
; (make-editor String Number)
; an editor has a string with the cursor positioned at index

(define editor1
  (make-editor "hello world" (string-length "hello world")))

; (editor-string editor1) ; hello world
; (editor-index editor1) ; 11


; Editor -> String
; return a editor's string until the editor's index
(check-expect (editor-pre (make-editor "hello" 0)) "")
(check-expect (editor-pre (make-editor "hello" (string-length "hello"))) "hello")
(check-expect (editor-pre (make-editor "hello" 3)) "hel")

(define (editor-pre ed)
  (substring (editor-string ed) 0 (editor-index ed)))

; Editor -> String
; return the editor's string from editor's index until end
(check-expect (editor-post (make-editor "hello" 0)) "hello")
(check-expect (editor-post (make-editor "hello" (string-length "hello"))) "")
(check-expect (editor-post (make-editor "hello" 3)) "lo")

(define (editor-post ed)
(substring (editor-string ed) (editor-index ed) (string-length (editor-string ed))))

; Render the editor
; Editor -> Image
(define (render e)  
   (overlay/align "left" "center"
                  (beside (text (editor-pre e) 16 "black")
                          (rectangle 1 20 "solid" "red")
                          (text (editor-post e) 16 "black"))
                  (empty-scene 200 20))
   )
(check-expect (render editor1)
              (overlay/align "left" "center"
                  (beside (text (editor-pre editor1) 16 "black")
                          (rectangle 1 20 "solid" "red")
                          (text (editor-post editor1) 16 "black"))
                  (empty-scene 200 20)))

; Backspace
; Editor -> Editor
; Remove the character to the left of the cursor
(define (backspace ed)
  (cond
    [(> (string-length (editor-pre ed)) 0)
     (make-editor
      (string-append (string-remove-last (editor-pre ed)) (editor-post ed))
      (- (string-length (editor-pre ed)) 1))]
    [else ed]
   )
)
(check-expect (backspace editor1) (make-editor "hello worl" 10))
(check-expect (backspace (make-editor "abcd" 4)) (make-editor "abc" 3))

; string-remove-last
; remove the last character of a string
; String -> String
(define (string-remove-last s)
  (substring s 0 (- (string-length s) 1))
)
(check-expect (string-remove-last "tree") "tre")

; string-remove-first
; remove the first character of a string
; String -> String
(define (string-remove-first s)
  (substring s 1 (string-length s))
)
(check-expect (string-remove-first "tree") "ree")

; string-first
; get the first character of a string
; String -> String
(define (string-first s)
  (substring s 0 1)
)
(check-expect (string-first "tree") "t")

; string-last
; get the last character of a string
; String -> String
(define (string-last s)
  (substring s (- (string-length s) 1) (string-length s))
)
(check-expect (string-last "tree") "e")

; move-left
; Editor -> Editor
(define (move-left ed) 
  (cond
    [(> (string-length (editor-pre ed)) 0)
     (make-editor
      (editor-string ed)
      (- (editor-index ed) 1))]
    [else ed]
   )                        
)
(check-expect (move-left (make-editor "hello world" 10)) (make-editor "hello world" 9))

; move-right
; Editor -> Editor
(define (move-right ed) 
  (cond
    [(> (string-length (editor-post ed)) 0)
     (make-editor
      (editor-string ed)
      (+ (editor-index ed) 1))]
    [else ed]
   )                        
)
(check-expect (move-right (make-editor "hello world" 5)) (make-editor "hello world" 6))

; Edit
; Editor, KeyEvent -> Editor
; Adds a character (0-1,a-z) ke to the end of the pre field of ed
; If backspace, removes a character to the left
; Limit the string lenght to 20 characters
;
(define (edit ed ke)
  (cond
    [(string=? "\b" ke) (backspace ed)]
    [(string=? "left" ke) (move-left ed)]
    [(string=? "right" ke) (move-right ed)]
    [(and (= (string-length ke) 1)
          (<= (string-length (editor-string ed)) 20))
     (make-editor
      (string-append (string-append (editor-pre ed) ke) (editor-post ed))
      (+ 1 (string-length (editor-pre ed)))
     )]    
    [else ed]
    )
)
(check-expect (edit editor1 "a")
              (make-editor (string-append "hello world" "a") 12))
(check-expect (edit editor1 "x")
              (make-editor (string-append (editor-pre editor1) "x")
                           (+ 1 (string-length (editor-pre editor1)))
               ))


(define (run ed)
  (big-bang ed
    [to-draw render]
    [on-key edit]
    ))

(run editor1)