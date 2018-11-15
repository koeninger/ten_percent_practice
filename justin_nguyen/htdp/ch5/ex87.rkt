;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex87) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


(define CURSOR (rectangle 1 20 "solid" "red"))
(define BOX (empty-scene 200 20))
(define TEXT-SIZE 16)
(define TEXT-COLOR "black")

; We use numbers to represent index and strings to represent text
; Editor is a struct:
;  (make-editor String Number)
; interpretation (make-editor s i) describes an editor whose
; visible text is s with the cursor placed after ith letter
(define-struct editor [text index])

; String -> Image
; creates text image from s based on our desired style
(check-expect (draw-text "hello") (text "hello" TEXT-SIZE TEXT-COLOR))
(check-expect (draw-text " ") (text " " TEXT-SIZE TEXT-COLOR))
(check-expect (draw-text "") (text "" TEXT-SIZE TEXT-COLOR))
(define (draw-text s)
  (text s TEXT-SIZE TEXT-COLOR))

; Editor -> Image
; draws text on empty scene with cursor at specified index
(check-expect (render (make-editor "hello" 0))
              (overlay/align
               "left" "center"
               (overlay/align/offset
                "left" "center"
                CURSOR
                (- (image-width (draw-text (substring "hello" 0 0)))) 0
                (draw-text "hello"))
               BOX))
(check-expect (render (make-editor "hello" 3))
              (overlay/align
               "left" "center"
               (overlay/align/offset
                "left" "center"
                CURSOR
                (- (image-width (draw-text (substring "hello" 0 3)))) 0
                (draw-text "hello"))
               BOX))
(check-expect (render (make-editor "" 0))
              (overlay/align
               "left" "center"
               (overlay/align/offset
                "left" "center"
                CURSOR
                (- (image-width (draw-text (substring "" 0 0)))) 0
                (draw-text ""))
               BOX))
(check-expect (render (make-editor "hello" 5))
              (overlay/align
               "left" "center"
               (overlay/align/offset
                "left" "center"
                CURSOR
                (- (image-width (draw-text (substring "hello" 0 5)))) 0
                (draw-text "hello"))
               BOX))
(define (render ed)
  (overlay/align
   "left" "center"
   (overlay/align/offset
    "left" "center"
    CURSOR
    (- (image-width (draw-text (substring (editor-text ed) 0 (editor-index ed))))) 0
    (draw-text (editor-text ed)))
   BOX))


; Editor KeyEvent -> Editor
; creates a new Editor based on input Editor and KeyEvent
; KeyEvent logic:
;  "\b"
;  "\t"
;  "\r"
;  all other input: insert input at editor-index and all chars to the right once index.
(define (edit ed ke)
  (cond
    [(string=? ke "\b") ...]
    [(string=? ke "\t") ...]
    [(string=? ke "\r") ...]
    [(string=? ke "left") ...]
    [(string=? ke "right") ...]
    [else ...]))
