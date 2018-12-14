;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |83|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(define cursor (rectangle 1 20 "solid" "red"))

; Editor -> image
; render displays the Editor
(check-expect (render (make-editor "hello " "world"))  (overlay/align "left" "center"
               (beside
                (text (editor-pre (make-editor "hello " "world")) 16 "black")
                cursor
                (text (editor-post (make-editor "hello " "world")) 16 "black"))
               (empty-scene 200 20))) 
(define (render ed)
  (overlay/align "left" "center"
               (beside
                (text (editor-pre ed) 16 "black")
                cursor
                (text (editor-post ed) 16 "black"))
               (empty-scene 200 20)))