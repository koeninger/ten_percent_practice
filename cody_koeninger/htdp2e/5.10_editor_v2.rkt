;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.10_editor_v2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/universe)


(define-struct editor [str pos])
; The v2 Editor is a structure:
;   (make-editor String Number)
; interpretation (make-editor s p) describes an editor
; whose visible text is s with 
; the cursor displayed before string index p

(define cursor (rectangle 1 20 "solid" "red"))
(define editor-font-size 16)
(define background (empty-scene 200 20))
(define (editor-text s) (text s editor-font-size "black"))

; hack to make the v2 representation of editor compatible with the code for the
; original representation based on pre and post-cursor strings
(define (editor-pre e)
  (substring (editor-str e) 0 (editor-pos e)))
(define (editor-post e)
  (substring (editor-str e) (editor-pos e)))

; editor -> image
; render editor
(check-expect (render (make-editor "quick" 3))
              (place-image/align (beside (editor-text "qui") cursor (editor-text "ck")) 0 0 "left" "top" background))
(define (render e)
  (place-image/align (beside (editor-text (editor-pre e)) cursor (editor-text (editor-post e))) 0 0 "left" "top" background))

; editor keyevent -> editor
; effect of keyevent on new state of editor
(check-expect (edit (make-editor "a" 0) "\t") (make-editor "a" 0))
(check-expect (edit (make-editor "a" 0) "\r") (make-editor "a" 0))
(check-expect (edit (make-editor "a" 0) "\b") (make-editor "a" 0))
(check-expect (edit (make-editor "abcd" 2) "\b") (make-editor "acd" 1))
(check-expect (edit (make-editor "a" 0) "left") (make-editor "a" 0))
(check-expect (edit (make-editor "a" 1) "left") (make-editor "a" 0))
(check-expect (edit (make-editor "a" 0) "right") (make-editor "a" 1))
(check-expect (edit (make-editor "a" 1) "right") (make-editor "a" 1))
(check-expect (edit (make-editor "" 0) "x") (make-editor "x" 1))
(check-expect (edit (make-editor "ab" 1) "x") (make-editor "axb" 2))
(define (edit e k)
  (cond
    [(or (key=? k "\t") (key=? k "\r") (key=? k "\r") (key=? k "shift") (key=? k "rshift"))
     e]
    [(key=? k "\b")
     (cursor-left (make-editor (string-append (string-remove-last (editor-pre e)) (editor-post e)) (editor-pos e)))]
    [(key=? k "left")
     (cursor-left e)]
    [(key=? k "right")
     (cursor-right e)]
    [else
     (if (editor-full? e)
         e
         (cursor-right (make-editor (string-append (editor-pre e) k (editor-post e)) (editor-pos e))))]))

; editor -> editor
; moves the cursor left, remaining in bounds
(check-expect (cursor-left (make-editor "" 0)) (make-editor "" 0))
(check-expect (cursor-left (make-editor "a" 1)) (make-editor "a" 0))
(define (cursor-left e)
  (make-editor (editor-str e)
               (if (<= (editor-pos e) 0)
                   0
                   (sub1 (editor-pos e)))))

; editor -> editor
; moves the cursor right, remaining in bounds
(check-expect (cursor-right (make-editor "" 0)) (make-editor "" 0))
(check-expect (cursor-right (make-editor "a" 0)) (make-editor "a" 1))
(define (cursor-right e)
  (make-editor (editor-str e)
               (if (>= (editor-pos e) (string-length (editor-str e)))
                   (string-length (editor-str e))
                   (add1 (editor-pos e)))))

; editor -> boolean
; whether the amount of text in the editor completely fills background
(check-expect (editor-full? (make-editor "" 0)) #false)
(check-expect (editor-full? (make-editor "1234567890123456789012" 0)) #true)
(define (editor-full? e)
  (>= (image-width (editor-text (string-append " " (editor-pre e) (editor-post e))))
     (image-width background)))

; string -> string
(check-expect (string-remove-last "") "")
(check-expect (string-remove-last "ab") "a")
(define (string-remove-last s)
  (if (< (string-length s) 1)
      ""
      (substring s 0 (sub1 (string-length s)))))

; string -> string
(check-expect (string-last "") "")
(check-expect (string-last "ab") "b")
(define (string-last s)
  (if (< (string-length s) 1)
      ""
      (string-ith s (sub1 (string-length s)))))

; string -> string
(check-expect (string-remove-first "") "")
(check-expect (string-remove-first "ab") "b")
(define (string-remove-first s)
  (if (< (string-length s) 1)
      ""
      (substring s 1)))

; string -> string
(check-expect (string-first "") "")
(check-expect (string-first "ab") "a")
(define (string-first s)
  (if (< (string-length s) 1)
      ""
      (string-ith s 0)))


; given a starting pre field for editor, runs interactive editor
(define (run pre)
  (big-bang (make-editor "" (string-length pre))
    [to-draw render]
    [on-key edit]))