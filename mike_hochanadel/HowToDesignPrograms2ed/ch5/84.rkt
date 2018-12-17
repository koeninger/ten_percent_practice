;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |84|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; working on it still

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

; Editor, KeyEvent -> Editor
; edit takes in a KeyEvent and modifies an Editor
;   given a valid event
(check-expect (event (make-editor "a" "b") "c") (make-editor "ac" "b"))
(check-expect (event (make-editor "" "b") "c") (make-editor "c" "b"))
(check-expect (event (make-editor "a" "") "c") (make-editor "ac" ""))
(check-expect (event (make-editor "hello" " world") ",") (make-editor "hello," " world"))
(check-expect (event (make-editor "hello" "world") " ") (make-editor "hello " "world"))
(check-expect (event (make-editor "a" "b") "\b") (make-editor "" "b"))
(check-expect (event (make-editor "a" "") "\b") (make-editor "" ""))
(check-expect (event (make-editor "" "b") "\b") (make-editor "" "b"))
(check-expect (event (make-editor "a" "b") "\t") (make-editor "a" "b"))
(check-expect (event (make-editor "a" "b") "\r") (make-editor "a" "b"))
(check-expect (event (make-editor "a" "b") "left") (make-editor "" "ab"))
(check-expect (event (make-editor "" "ab") "left") (make-editor "" "ab"))
(check-expect (event (make-editor "" "") "left") (make-editor "" ""))
(check-expect (event (make-editor "a" "b") "right") (make-editor "ab" ""))
(check-expect (event (make-editor "ab" "") "right") (make-editor "ab" ""))
(check-expect (event (make-editor "" "") "right") (make-editor "" ""))
(check-expect (event (make-editor "a" "b") "up") (make-editor "a" "b"))
(check-expect (event (make-editor "a" "b") "down") (make-editor "a" "b"))
(check-expect (event (make-editor "a" "b") "f1") (make-editor "a" "b"))
(check-expect (event (make-editor "a" "b") "shift") (make-editor "a" "b"))
(check-expect (event (make-editor "a" "b") "escape") (make-editor "a" "b"))
(define (event ed ke)
  (cond [(= (string-length ke) 1)
         (cond [(or (= ke "\t") (= ke "\r")) ])
         ]))
         
  