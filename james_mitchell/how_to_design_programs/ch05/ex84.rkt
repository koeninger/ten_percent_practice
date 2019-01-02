;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex84) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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

; Edit
; Editor, KeyEvent -> Editor
; Adds a character (0-1,a-z) ke to the end of the pre field of ed
; If backspace, removes a character to the left
(define (edit ed ke)
  (cond
    [(and (= (string-length ke) 1) (or (string<=? "a" ke "z") (string<=? "0" ke "9")))
     (make-editor (string-append (editor-pre ed) ke) (editor-post ed))]
    [(string=? ke "\b") (backspace ed)]
    [(string=? "left" ke) (move-left ed)]
    [(string=? "right" ke) (move-right ed)]
    [(string=? ke "\t") ed]
    [(string=? ke "\r") ed]
    [(> (image-width (render ed)) WIDTH) ed]
    [else ed]
    )
)


; String Index Char -> String
; Inserts character at index
(define (string-insert str i c)
  (string-append (substring str 0 i) c (substring str (+ i 0) (string-length str))))

; String Index -> String
; Removes character at index
(define (string-delete str i)
  (cond
    [(> i 0) (string-append (substring str 0 (- i 1)) (substring str (+ (- i 1) 1) (string-length str)))]
    [else str]))

; Backspace
; Editor -> Editor
; Remove the character to the left of the cursor
(define (backspace ed)
  (cond
    [(> (string-length (editor-pre ed)) 0)
     (make-editor
      (string-remove-last (editor-pre ed))
      (editor-post ed))]
    [else ed]
   )
)
(check-expect (backspace editor1) (make-editor "hell" "world"))
(check-expect (backspace (make-editor "ab" "cd")) (make-editor "a" "cd"))
(check-expect (backspace (make-editor "" "world")) (make-editor "" "world"))

; move-left
; Editor -> Editor
(define (move-left ed) 
  (cond
    [(> (string-length (editor-pre ed)) 0)
     (make-editor
      (string-remove-last (editor-pre ed))
      (string-append (string-last (editor-pre ed)) (editor-post ed)))]
    [else ed]
   )                        
)
(check-expect (move-left (make-editor "hello" "world")) (make-editor "hell" "oworld"))

; move-right
; Editor -> Editor
(define (move-right ed) 
  (cond
    [(> (string-length (editor-post ed)) 0)
     (make-editor
      (string-append (editor-pre ed) (string-first (editor-post ed)))
      (string-remove-first (editor-post ed)))]
    [else ed]
   )                        
)
(check-expect (move-right (make-editor "hello" "world")) (make-editor "hellow" "orld"))

; string-remove-last
; remove the last character of a string
; String -> String
(define (string-remove-last s)
  (substring s 0 (- (string-length s) 1))
)
(check-expect (string-remove-last "tree") "tre")

; string-remove-first
; remove the first character of a string
; String -> String
(define (string-remove-first s)
  (substring s 1 (string-length s))
)
(check-expect (string-remove-first "tree") "ree")

; string-first
; get the first character of a string
; String -> String
(define (string-first s)
  (substring s 0 1)
)
(check-expect (string-first "tree") "t")

; string-last
; get the last character of a string
; String -> String
(define (string-last s)
  (substring s (- (string-length s) 1) (string-length s))
)
(check-expect (string-last "tree") "e")

(render editor1)