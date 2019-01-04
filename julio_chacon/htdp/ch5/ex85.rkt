;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex85) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t



(define (render ed)
  (overlay/align "left" "center"
              (beside
               (text (editor-pre ed) 11 "black")
               (rectangle 1 20 "solid" "red")
               (text (editor-post ed) 11 "black"))
               (empty-scene 200 20)))


(check-expect (edit (make-editor "pre" "post") "\b")  (make-editor "pr" "post"))
(check-expect (edit (make-editor "pre" "post") "\t") (make-editor "pre" "post"))
(check-expect (edit (make-editor "pre" "post") "\r") (make-editor "pre" "post"))
(check-expect (edit (make-editor "pre" "post") "right") (make-editor "prep" "ost"))
(check-expect (edit (make-editor "pre" "post") "left") (make-editor "pr" "epost"))
(check-expect (edit (make-editor "pre" "post") "a")  (make-editor "prea" "post"))
(check-expect (edit (make-editor "pre" "post") "b")  (make-editor "preb" "post"))
(check-expect (edit (make-editor "pre" "post") "c")  (make-editor "prec" "post"))
(check-expect (edit (make-editor "pre" "post") "x")  (make-editor "prex" "post"))
(check-expect (edit (make-editor "pre" "post") "y")  (make-editor "prey" "post"))
(check-expect (edit (make-editor "pre" "post") "z")  (make-editor "prez" "post"))

; Editor KeyEvent -> Editor 
; returns editor based on keyevent passed,
(define (edit ed ke)
  (cond
    [(string=? "\b" ke) (make-editor (string-remove-last (editor-pre ed)) (editor-post ed))]
    [(or (string=? "\t" ke) (string=? "\r" ke)) (make-editor (editor-pre ed) (editor-post ed))]
    [(string=? "left" ke) (make-editor
                           (string-remove-last (editor-pre ed))
                           (string-append (string-last (editor-pre ed)) (editor-post ed)))]
    [(string=? "right" ke) (make-editor
                            (string-append (editor-pre ed) (string-first (editor-post ed)) )
                            (string-remove-first  (editor-post ed)))]
    [else (make-editor (string-add (editor-pre ed) ke) (editor-post ed) )]))


; String String -> String 
; adds char to end of txt,
; char is single character
; txt is previous text passed
(define (string-add txt char)
  (string-append txt char))

; String -> String 
; removes char from end of txt,
; char is single character
; txt is text passed
(define (string-remove-last txt)
  ( substring txt 0 (- (string-length txt) 1 ) ))


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

(run (make-editor "hello" "world"))
