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
;  "\b" remove char at editor-index - 1
;  "\t" do nothing
;  "\r" do nothing
;  all other input: insert input at editor-index and
;  move char at index and all chars to the right of it once
(check-expect (edit (make-editor "a" 0) "b") (make-editor "ba" 1))
(check-expect (edit (make-editor "a" 1) "b") (make-editor "ab" 2))
(check-expect (edit (make-editor "abc" 2) "f") (make-editor "abfc" 3))
(check-expect (edit (make-editor "" 0) "b") (make-editor "b" 1))
(check-expect (edit (make-editor "a" 1) "\b") (make-editor "" 0))
(check-expect (edit (make-editor "ab" 1) "\b") (make-editor "b" 0))
(check-expect (edit (make-editor "a" 0) "\b") (make-editor "a" 0))
(check-expect (edit (make-editor "a" 0) "right") (make-editor "a" 1))
(check-expect (edit (make-editor "a" 1) "right") (make-editor "a" 1))
(check-expect (edit (make-editor "ab" 0) "right") (make-editor "ab" 1))
(check-expect (edit (make-editor "a" 0) "left") (make-editor "a" 0))
(check-expect (edit (make-editor "a" 1) "left") (make-editor "a" 0))
(check-expect (edit (make-editor "ab" 1) "left") (make-editor "ab" 0))
(check-expect (edit (make-editor "a" 1) "\t") (make-editor "a" 1))
(check-expect (edit (make-editor "a" 1) "\r") (make-editor "a" 1))

(define (edit ed ke)
  (cond
    [(string=? ke "\b") (if (> (editor-index ed) 0)
                            (make-editor
                             (string-append
                              (substring (editor-text ed) 0 (- (editor-index ed) 1))
                              (substring (editor-text ed) (editor-index ed) (string-length (editor-text ed))))
                             (- (editor-index ed) 1))
                            ed)]
    [(string=? ke "\t") ed]
    [(string=? ke "\r") ed]
    [(string=? ke "left") (if (> (editor-index ed) 0)
                              (make-editor (editor-text ed) (- (editor-index ed) 1))
                              ed)]
    [(string=? ke "right") (if (< (editor-index ed) (string-length (editor-text ed)))
                               (make-editor (editor-text ed) (+ (editor-index ed) 1))
                               ed)]
    [else (if (< (image-width (draw-text (editor-text (insert-char ed ke)))) (image-width BOX))
              (insert-char ed ke)
              ed)]))

(define (insert-char ed c)
  (make-editor
   (string-append
    (substring (editor-text ed) 0 (editor-index ed))
    c
    (substring (editor-text ed) (editor-index ed) (string-length (editor-text ed))))
   (+ (editor-index ed) 1)))

(define (run t)
  (big-bang (make-editor t 0)
    [to-draw render]
    [on-key edit]))