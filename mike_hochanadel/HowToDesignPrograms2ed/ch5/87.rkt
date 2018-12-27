;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |87|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct editor [editor-text cursor-position])
; An Editor is a structure:
;   (make-editor String Number)
; interpretation (make-editor (editor-text cursor-position)
; describes an editor
; whose visible text is (editor-text) with 
; the cursor displayed at position (cursor-position)

(define EDITOR_WIDTH 200)
(define EDITOR_HEIGHT 20)
(define EDITOR_TEXT_SIZE 16)
(define CURSOR (rectangle 1 20 "solid" "red"))

; String -> String
; string-remove-last will take in a string and return a string with the last
; character removed
(check-expect (string-remove-last "String") "Strin")
(check-expect (string-remove-last "42") "4")
(check-expect (string-remove-last "") "")
(define (string-remove-last str)
    (if (> (string-length str) 0)
      (substring str 0 (- (string-length str) 1))
      ""
    ))

; Editor -> Number
; cursor-location gets the x pixel location of the
; cursor-position in an Editor
(check-expect (cursor-location (make-editor "hello world" 0)) 0)
(check-expect (cursor-location (make-editor "hello world" 3)) (image-width
   (text (substring (editor-editor-text (make-editor "hello world" 3))
                    0
                    (editor-cursor-position (make-editor "hello world" 3)))
         EDITOR_TEXT_SIZE
         "black")))
(define (cursor-location ed)
  (image-width
   (text (substring (editor-editor-text ed) 0 (editor-cursor-position ed))
         EDITOR_TEXT_SIZE
         "black")))

; Editor -> Editor
; delete-character-editor deletes a character behind the cursor position
(check-expect (delete-character-editor (make-editor "hello world" 0)) (make-editor "hello world" 0))
(check-expect (delete-character-editor (make-editor "hello world" 1)) (make-editor "ello world" 0))
(check-expect (delete-character-editor (make-editor "hello world" (string-length "hello world")))
              (make-editor "hello worl" (string-lentgh "hello worl")))
(define (delete-character-editor ed)
  ed)

; Editor, KeyEvent -> Editor
; add-character-editor adds the KeyEvent character given to the
;  editor at the current cursor position
(define (add-character-editor ed ke)
  ed)

; Editor, KeyEvent -> Editor
; edit takes in a KeyEvent and modifies an Editor
;   given a valid event
(check-expect (edit (make-editor "a" "b") "c") (make-editor "ac" "b"))
(check-expect (edit (make-editor "" "b") "c") (make-editor "c" "b"))
(check-expect (edit (make-editor "a" "") "c") (make-editor "ac" ""))
(check-expect (edit (make-editor "hello" " world") ",") (make-editor "hello," " world"))
(check-expect (edit (make-editor "hello" "world") " ") (make-editor "hello " "world"))
(check-expect (edit (make-editor "a" "b") "\b") (make-editor "" "b"))
(check-expect (edit (make-editor "a" "") "\b") (make-editor "" ""))
(check-expect (edit (make-editor "" "b") "\b") (make-editor "" "b"))
(check-expect (edit (make-editor "a" "b") "\t") (make-editor "a" "b"))
(check-expect (edit (make-editor "a" "b") "\r") (make-editor "a" "b"))
(check-expect (edit (make-editor "a" "b") "left") (make-editor "" "ab"))
(check-expect (edit (make-editor "" "ab") "left") (make-editor "" "ab"))
(check-expect (edit (make-editor "" "") "left") (make-editor "" ""))
(check-expect (edit (make-editor "a" "b") "right") (make-editor "ab" ""))
(check-expect (edit (make-editor "ab" "") "right") (make-editor "ab" ""))
(check-expect (edit (make-editor "" "") "right") (make-editor "" ""))
(check-expect (edit (make-editor "a" "b") "up") (make-editor "a" "b"))
(check-expect (edit (make-editor "a" "b") "down") (make-editor "a" "b"))
(check-expect (edit (make-editor "a" "b") "f1") (make-editor "a" "b"))
(check-expect (edit (make-editor "a" "b") "shift") (make-editor "a" "b"))
(check-expect (edit (make-editor "a" "b") "escape") (make-editor "a" "b"))
(define (edit ed ke)
  (cond [(= (string-length ke) 1)
         (cond [(or (string=?  ke "\t") (string=?  ke "\r")) ed]
               [(string=?  ke "\b") (delete-character-editor ed)]
               [else (add-character-editor ed ke)]
         )]
        [(string=?  "left" ke)
         (cond [(= (editor-cursor-position ed) 0) ed]
               [else (make-editor (editor-editor-text ed) (- (editor-cursor-position ed) 1))])
        [(string=?  "right" ke) (make-editor
         (cond [(= (editor-cursor-position ed) (string-length (editor-editor-text))) ed]
               [else (make-editor (editor-editor-text ed) (+ (editor-cursor-position ed) 1))])
        [else ed]))

; Editor -> image
; render displays the Editor
(check-expect (render (make-editor "hello world" 0))  (overlay/align "left" "center"
               (overlay/align/offset "left" "center"
                                     (text (editor-editor-text
                                            (make-editor "hello world" 0))
                                           EDITOR_TEXT_SIZE "black")
                                     (cursor-location (make-editor "hello world" 0)) 0
                                     CURSOR)
                (empty-scene EDITOR_WIDTH EDITOR_HEIGHT)))
(check-expect (render (make-editor "hello world" 6))  (overlay/align "left" "center"
               (overlay/align/offset "left" "center"
                                     (text (editor-editor-text
                                            (make-editor "hello world" 6))
                                           EDITOR_TEXT_SIZE "black")
                                     (cursor-location (make-editor "hello world" 6)) 0
                                     CURSOR)
                (empty-scene EDITOR_WIDTH EDITOR_HEIGHT))) 
(define (render ed)
  (overlay/align "left" "center"
               (overlay/align/offset "left" "center"
                                     (text (editor-editor-text ed) EDITOR_TEXT_SIZE "black")
                                     (cursor-location ed) 0
                                     CURSOR)
               (empty-scene EDITOR_WIDTH EDITOR_HEIGHT)))

; Editor -> Editor
; launches the program from an initial Editor
(define (run editor-text)
  (big-bang (make-editor editor-text 0)
    [on-key edit]
    [on-draw render]))