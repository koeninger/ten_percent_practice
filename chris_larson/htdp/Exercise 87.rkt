;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 87|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; definitions
(define WIDTH 200)

(define-struct editor [text index])
; An Editor is a structure:
;  (make-editor String Int)
; Interpretation (make-editor s i) describes an editor
; whose visible text is s with the cursor displayed at
; index i of string s

; Editor -> Image
; renders text in an empty scene with a red bar at the index
(define (render e)
  (overlay/align "left" "center"
                 (beside/align "middle"
                               (text (substring (editor-text e) 0 (editor-index e)) 11 "black")
                               (rectangle 1 20 "solid" "red")
                               (text (substring (editor-text e) (editor-index e)) 11 "black"))
                 (empty-scene WIDTH 20)))

