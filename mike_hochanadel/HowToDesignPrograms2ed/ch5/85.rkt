;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |85|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(define cursor (rectangle 1 20 "solid" "red"))

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
               [(string=?  ke "\b") (make-editor
                             (string-remove-last (editor-pre ed))
                             (editor-post ed))]
               [else (make-editor
                     (string-append (editor-pre ed) ke)
                     (editor-post ed))]
         )]
        [(string=?  "left" ke) (make-editor
                         (string-remove-last (editor-pre ed))
                         (string-append (string-last (editor-pre ed)) (editor-post ed)))]
        [(string=?  "right" ke) (make-editor
                         (string-append (editor-pre ed) (string-first (editor-post ed)))
                         (string-rest (editor-post ed)))]
        [else ed]))


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

; Editor -> Editor
; launches the program from an initial Editor
(define (run pre)
  (big-bang (make-editor pre "")
    [on-key edit]
    [on-draw render]))