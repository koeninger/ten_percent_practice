;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex83) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define WIDTH 200)

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(define cursor (rectangle 1 20 "solid" "red"))
(define editor1 (make-editor "hello" "world"))

; Editor -> Image
; renders text in an empty scene with a red bar between pre and post
(define (render editor)
  (overlay/align "left" "center"
               (beside/align "middle"
                             (text (editor-pre editor) 16 "black")
                             (rectangle 1 20 "solid" "red")
                             (text (editor-post editor) 16 "black"))
               (empty-scene WIDTH 20)))


(check-expect (render editor1)
              (overlay/align "left" "center"
                  (beside/align "middle"
                          (text (editor-pre editor1) 16 "black")
                          (rectangle 1 20 "solid" "red")
                          (text (editor-post editor1) 16 "black"))
                  (empty-scene WIDTH 20)))

(render editor1)