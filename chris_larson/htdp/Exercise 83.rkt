;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 83|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))


(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

; Editor -> Image
; renders text in an empty scene with a red bar between pre and post
(define (render e)
  (overlay/align "left" "center"
               (beside/align "middle"
                             (text (editor-pre e) 11 "black")
                             (rectangle 1 20 "solid" "red")
                             (text (editor-post e) 11 "black"))
               (empty-scene 200 20)))

; Editor KeyEvent -> Editor
; adds a single char to end of pre
; if key is backspace then it deletes the last char of pre
(define (edit ed ke)
  (cond
  [(string=? ke "\b") (make-editor (string-remove-last (editor-pre ed)) (editor-post ed))]
  [(string=? ke "left") (make-editor (string-remove-last (editor-pre ed)) (string-append (string-last (editor-pre ed)) (editor-post ed))) ]
  [(string=? ke "right") (make-editor (string-append (editor-pre ed) (string-first (editor-post ed))) (string-remove-first (editor-post ed)))]
  [(string=? ke "\t") ed]
  [(string=? ke "\r") ed]
  [else (make-editor (string-append (editor-pre ed) ke) (editor-post ed))]))

(check-expect (edit (make-editor "hello" "world") "right") (make-editor "hellow" "orld"))
(check-expect (edit (make-editor "hello" "world") "left") (make-editor "hell" "oworld"))
(check-expect (edit (make-editor "hello" "world") "\b") (make-editor "hell" "world"))
(check-expect (edit (make-editor "hello" "world") " ") (make-editor "hello " "world"))

; String -> 1String
; returns the first 1String from a String
(define (string-first s)
  (substring s 0 1))
(check-expect (string-first "Hello World!") "H")
(check-expect (string-first "\bHello World!") "\b")

; String -> 1String
; returns the last 1String from a String
(define (string-last s)
  (substring s (- (string-length s) 1)))
(check-expect (string-last "Hello World!") "!")
(check-expect (string-last "Hello World!\b") "\b")

; String -> String
; removes the last 1String from a String
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))
(check-expect (string-remove-last "Hello World!") "Hello World")
(check-expect (string-remove-last "Hello World!\b") "Hello World!")

; String -> String
; removes the first 1String from a String
(define (string-remove-first str)
  (substring str 1 (string-length str)))
(check-expect (string-remove-first "Hello World!") "ello World!")
(check-expect (string-remove-first "\bHello World!") "Hello World!")

;
(define (run pre)
  (big-bang (make-editor pre "")
    [to-draw render]
    [on-key edit]))