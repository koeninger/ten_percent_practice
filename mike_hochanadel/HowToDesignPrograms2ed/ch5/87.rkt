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
              (make-editor "hello worl" (string-length "hello worl")))
(define (delete-character-editor ed)
  (make-editor
   (string-append
    (string-remove-last (substring (editor-editor-text ed) 0 (editor-cursor-position ed)))
    (substring (editor-editor-text ed) (editor-cursor-position ed)))
   (cond
     [(= (editor-cursor-position ed) 0) 0]
     [else (- (editor-cursor-position ed) 1)])
  ))

; Editor, KeyEvent -> Editor
; add-character-editor adds the KeyEvent character given to the
;  editor at the current cursor position
(check-expect (add-character-editor (make-editor "hello world" 0) "y") (make-editor "yhello world" 1))
(check-expect (add-character-editor (make-editor "hello world" 1) "y") (make-editor "hyello world" 2))
(check-expect (add-character-editor (make-editor "hello world" (string-length "hello world")) "y")
              (make-editor "hello worldy" (string-length "hello worldy")))
(define (add-character-editor ed ke)
  (make-editor
   (string-append
    (string-append (substring (editor-editor-text ed) 0 (editor-cursor-position ed)) ke)
    (substring (editor-editor-text ed) (editor-cursor-position ed)))
   (+ (editor-cursor-position ed) 1))
  )

; Editor, KeyEvent -> Editor
; edit takes in a KeyEvent and modifies an Editor
;   given a valid event
(check-expect (edit (make-editor "ab" 2) "c") (make-editor "abc" 3))
(check-expect (edit (make-editor "ab" 0) "\b") (make-editor "ab" 0))
(check-expect (edit (make-editor "ab" 1) "\b") (make-editor "b" 0))
(check-expect (edit (make-editor "ab" 2) "\b") (make-editor "a" 1))
(check-expect (edit (make-editor "ab" 0) "\t") (make-editor "ab" 0))
(check-expect (edit (make-editor "ab" 0) "\r") (make-editor "ab" 0))
(check-expect (edit (make-editor "ab" 0) "left") (make-editor "ab" 0))
(check-expect (edit (make-editor "ab" 1) "left") (make-editor "ab" 0))
(check-expect (edit (make-editor "" 0) "left") (make-editor "" 0))
(check-expect (edit (make-editor "ab" 0) "right") (make-editor "ab" 1))
(check-expect (edit (make-editor "ab" 2) "right") (make-editor "ab" 2))
(check-expect (edit (make-editor "" 0) "right") (make-editor "" 0))
(check-expect (edit (make-editor "ab" 1) "up") (make-editor "ab" 1))
(check-expect (edit (make-editor "ab" 2) "down") (make-editor "ab" 2))
(check-expect (edit (make-editor "ab" 0) "f1") (make-editor "ab" 0))
(check-expect (edit (make-editor "ab" 1) "shift") (make-editor "ab" 1))
(check-expect (edit (make-editor "ab" 2) "escape") (make-editor "ab" 2))
(define (edit ed ke)
  (cond [(= (string-length ke) 1)
         (cond [(or (string=?  ke "\t") (string=?  ke "\r")) ed]
               [(string=?  ke "\b") (delete-character-editor ed)]
               [else (add-character-editor ed ke)]
         )]
        [(string=?  "left" ke)
         (cond [(= (editor-cursor-position ed) 0) ed]
               [else (make-editor (editor-editor-text ed) (- (editor-cursor-position ed) 1))])]
        [(string=?  "right" ke)
          (cond [(= (editor-cursor-position ed) (string-length (editor-editor-text ed))) ed]
                [else (make-editor
                       (editor-editor-text ed)
                       (+ (editor-cursor-position ed) 1))])]
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