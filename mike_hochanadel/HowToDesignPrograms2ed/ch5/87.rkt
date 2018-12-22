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


; String -> 1String
; string-first extracts the first character from a non-empty string
(check-expect (string-first "String") "S")
(check-expect (string-first "42") "4")
(check-expect (string-first "") "")
(define (string-first string)
  (if (and (string? string) (> (string-length string) 0))
      (string-ith string 0)
      ""
      ))

; String -> 1String
; string-last extracts the last character from a non-empty string
(check-expect (string-last "String") "g")
(check-expect (string-last "42") "2")
(check-expect (string-last "") "")
(define (string-last string)
  (if (and (string? string) (> (string-length string) 0))
      (string-ith string (- (string-length string) 1))
      ""
      ))

; String -> String
; string-rest will take in a string and return a string with the 1st character
; removed
(check-expect (string-rest "String") "tring")
(check-expect (string-rest "42") "2")
(check-expect (string-rest "") "")
(define (string-rest str)
    (if (> (string-length str) 0)
      (substring str 1 (string-length str))
      ""
    ))

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
(define (cursor-location ed)
  (image-width
   (text (string-ith (editor-editor-text ed) (editor-cursor-position))
         EDITOR_TEXT_SIZE
         "black")))
 


; Editor -> image
; render displays the Editor
(check-expect (render (make-editor "hello world" 0))  (overlay/align "left" "center"
               (beside
                (text (editor-pre (make-editor "hello " "world")) EDITOR_TEXT_SIZE "black")
                CURSOR
                (text (editor-post (make-editor "hello " "world")) EDITOR_TEXT_SIZE "black"))
               (empty-scene EDITOR_WIDTH EDITOR_HEIGHT))) 
(define (render ed)
  (overlay/align "left" "center"
               (beside
                (text (editor-pre ed) EDITOR_TEXT_SIZE "black")
                CURSOR
                (text (editor-post ed) EDITOR_TEXT_SIZE "black"))
               (empty-scene EDITOR_WIDTH EDITOR_HEIGHT)))