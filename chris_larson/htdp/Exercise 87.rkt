;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 87|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; definitions
(define WIDTH 200)

(define-struct editor [text index])
; An Editor is a structure:
;  (make-editor String Int)
; Interpretation (make-editor s i) describes an editor
; whose visible text is s with the cursor displayed at
; index i of string s

; Editor -> Image
; renders text in an empty scene with a red bar at the index
(define (render e)
  (overlay/align "left" "center"
                 (beside/align "middle"
                               (text (substring (editor-text e) 0 (editor-index e)) 11 "black")
                               (rectangle 1 20 "solid" "red")
                               (text (substring (editor-text e) (editor-index e)) 11 "black"))
                 (empty-scene WIDTH 20)))

; Editor KeyEvent -> Editor
; adds a single char to text at index
; if key is backspace then it deletes the char left of index
(define (edit ed ke)
  (cond
    [(string=? ke "\b") (make-editor (string-delete (editor-text ed) (editor-index ed)) (dec-index ed)) ]
    [(string=? ke "left") (make-editor (editor-text ed) (cursor-left ed))]
    [(string=? ke "right") (make-editor (editor-text ed) (cursor-right ed))]
    [(string=? ke "\t") ed]
    [(string=? ke "\r") ed]
    [(> (image-width (render ed)) WIDTH) ed]
    [else (make-editor (string-insert (editor-text ed) (editor-index ed) ke) (+ (editor-index ed) 1))]))

(check-expect (edit (make-editor "hello world" 0) "right") (make-editor "hello world" 1))
(check-expect (edit (make-editor "hello world" 0) "left") (make-editor "hello world" 0))
(check-expect (edit (make-editor "hello world" 1) "\b") (make-editor "ello world" 0))
(check-expect (edit (make-editor "hello world" 0) "\b") (make-editor "hello world" 0))
(check-expect (edit (make-editor "hello world" 0) " ") (make-editor " hello world" 1))
(check-expect (edit (make-editor "hello world" 0) "\t") (make-editor "hello world" 0))
(check-expect (edit (make-editor "hello world" 0) "\r") (make-editor "hello world" 0))
(check-expect (edit (make-editor "hello worldrealyrealyrealyrealyrealyrealyrealyrealyrealyrealylonglonglonglonglonglonglong" 0) " ") (make-editor "hello worldrealyrealyrealyrealyrealyrealyrealyrealyrealyrealylonglonglonglonglonglonglong" 0))


(define (string-insert str i c)
  (string-append (substring str 0 i) c (substring str (+ i 0) (string-length str))))

(define (string-delete str i)
  (cond
    [(> i 0) (string-append (substring str 0 (- i 1)) (substring str (+ (- i 1) 1) (string-length str)))]
    [else str]))

(define (dec-index ed)
  (cond
    [(< (editor-index ed) 1) 0]
    [else (- (editor-index ed) 1)]))

(define (cursor-left ed)
  (cond
    [(> (editor-index ed) 0) (- (editor-index ed) 1)]
    [else 0]))

(define (cursor-right ed)
  (cond
    [(< (editor-index ed) (string-length (editor-text ed))) (+ (editor-index ed) 1)]
    [else (- (string-length (editor-index ed)) 1)]))

(define (run pre)
  (big-bang (make-editor pre (- (string-length pre) 1))
    [to-draw render]
    [on-key edit]))