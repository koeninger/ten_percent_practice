;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |83|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;(define-struct space-game [ufo tank])
;
; A SpaceGame is a structure:
;   (make-space-game Posn Number). 
; interpretation (make-space-game (make-posn ux uy) tx)
; describes a configuration where the UFO is 
; at (ux,uy) and the tank's x-coordinate is tx

; --------------------------

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

(render editor1)
