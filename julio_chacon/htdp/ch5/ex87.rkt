;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex87) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct editor [txt idx])
; An Editor is a structure:
;   (make-editor String Number)
; interpretation (make-editor s n) describes an editor
; whose visible text has cursor at nth index.


; Editor -> Image 
; returns image with cursor,
(define (txtRender ed)
  
  (beside
   (text (pre ed)  11 "black")
   (rectangle 1 20 "solid" "red")
   (text (post ed)  11 "black")
   )
  )



(define (render ed)
  (overlay/align "left" "center"
                 (txtRender ed)
               (empty-scene 200 20)))


;(check-expect (edit (make-editor "pre" "post") "\b")  (make-editor "pr" "post"))
;(check-expect (edit (make-editor "pre" "post") "\t") (make-editor "pre" "post"))
;(check-expect (edit (make-editor "pre" "post") "\r") (make-editor "pre" "post"))
;(check-expect (edit (make-editor "pre" "post") "yo") (make-editor "pre" "post"))
;(check-expect (edit (make-editor "pre" "post") "right") (make-editor "prep" "ost"))
;(check-expect (edit (make-editor "pre" "post") "left") (make-editor "pr" "epost"))
;(check-expect (edit (make-editor "pre" "post") "a")  (make-editor "prea" "post"))
;(check-expect (edit (make-editor "pre" "post") "b")  (make-editor "preb" "post"))
;(check-expect (edit (make-editor "pre" "post") "c")  (make-editor "prec" "post"))
;(check-expect (edit (make-editor "pre" "post") "x")  (make-editor "prex" "post"))
;(check-expect (edit (make-editor "pre" "post") "y")  (make-editor "prey" "post"))
;(check-expect (edit (make-editor "pre" "post") "z")  (make-editor "prez" "post"))

; Editor KeyEvent -> Editor 
; returns editor based on keyevent passed,
(define (edit ed ke)
  (cond
    [(or (string=? "\t" ke) (string=? "\r" ke)) ed]
    [(and (string=? "\b" ke) (> (editor-idx ed) 0))
     (make-editor
      (string-append (string-remove-last (pre ed)) (post ed))
      (- (editor-idx ed) 1))]
    [(and (= (string-length ke) 1) (< (image-width (txtRender (make-editor (string-add ed ke) (+ (editor-idx ed) 1)) ))  200))
     (make-editor (string-add ed ke) (+ (editor-idx ed) 1)) ]


    [(and (string=? "left" ke) (> (editor-idx ed) 0))
     (make-editor (editor-txt ed) (- (editor-idx ed) 1))]
    [(and (string=? "right" ke) (< (editor-idx ed) (string-length (editor-txt ed))))
     (make-editor (editor-txt ed) (+ (editor-idx ed) 1))]
    
    [else ed]))



(define (pre ed)
  (substring (editor-txt ed) 0 (editor-idx ed)) )

(define (post ed)
  (substring (editor-txt ed) (editor-idx ed)) )



; String String -> String 
; adds char to end of txt,
; char is single character
; txt is previous text passed
(define (string-add ed char)
  (string-append (pre ed) char (post ed)))

; String -> String 
; removes char from end of txt,
; char is single character
; txt is text passed
(define (string-remove-last txt)
  (substring txt 0 (- (string-length txt) 1 ) ))


; String -> String 
; removes char from begining of txt,
; char is single character
; txt is text passed
(define (string-remove-first txt)
  ( substring txt 1 ))


; String -> String 
; returns first character from text,
; char is single character
; txt is text passed
(define (string-first txt)
  ( string-ith  txt 0 ))


; String -> String 
; returns last character from text,
; char is single character
; txt is text passed
(define (string-last txt)
  ( substring  txt (- (string-length txt) 1 ) ))

(define (run ed)
  (big-bang ed
    [to-draw render]
    [on-key edit]
    ))

(run (make-editor "juliochacon" 7))