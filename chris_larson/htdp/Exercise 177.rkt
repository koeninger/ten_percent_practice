;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 177|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define HEIGHT 20) ; the height of the editor 
(define WIDTH 200) ; its width 
(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color 
 
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)

(define good
  (cons "g" (cons "o" (cons "o" (cons "d" '())))))
(define all
  (cons "a" (cons "l" (cons "l" '()))))
(define lla
  (cons "l" (cons "l" (cons "a" '()))))
 
; Lo1s -> Lo1s 
; produces a reverse version of the given list 
(define (rev l)
  (cond
    [(empty? l) '()]
    [else (add-at-end (rev (rest l)) (first l))]))

(check-expect
  (rev (cons "a" (cons "b" (cons "c" '()))))
  (cons "c" (cons "b" (cons "a" '()))))

; Lo1s 1String -> Lo1s
; creates a new list by adding s to the end of l
(define (add-at-end l s)
  (cond
  [(empty? l) (cons s '())]
  [else (cons (first l)  (add-at-end (rest l) s))]))

(check-expect
  (add-at-end (cons "c" (cons "b" '())) "a")
  (cons "c" (cons "b" (cons "a" '()))))
 
; String String -> Editor
; Combines 2 strings to make an editor
(define (create-editor s1 s2)
  (make-editor (rev (explode s1)) (explode s2)))
(check-expect (create-editor "all" "good") (make-editor lla good))
 
; Editor KeyEvent -> Editor
; deals with a key event, given some editor
(define (editor-kh ed k)
  (cond
    [(key=? k "left") (editor-lft ed)]
    [(key=? k "right") (editor-rgt ed)]
    [(key=? k "\b") (editor-del ed)]
    [(key=? k "\t") ed]
    [(key=? k "\r") ed]
    [(= (string-length k) 1) (editor-ins ed k)]
    [else ed]))
(check-expect (editor-kh (create-editor "" "") "e")
              (create-editor "e" ""))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "e")
  (create-editor "cde" "fgh"))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "\b")
  (create-editor "c" "fgh"))
(check-expect
  (editor-kh (create-editor "" "fgh") "\b")
  (create-editor "" "fgh"))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "left")
  (create-editor "c" "dfgh"))
(check-expect
  (editor-kh (create-editor "" "cdfgh") "left")
  (create-editor "" "cdfgh"))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "right")
  (create-editor "cdf" "gh"))
(check-expect
  (editor-kh (create-editor "cdfgh" "") "right")
  (create-editor "cdfgh" ""))

; Editor -> Editor
; insert the 1String k between pre and post
(define (editor-ins ed k)
  (make-editor (cons k (editor-pre ed))
               (editor-post ed)))
(check-expect
  (editor-ins (make-editor '() '()) "e")
  (make-editor (cons "e" '()) '()))
(check-expect
  (editor-ins
    (make-editor (cons "d" '())
                 (cons "f" (cons "g" '()))) "e")
  (make-editor (cons "e" (cons "d" '()))
               (cons "f" (cons "g" '()))))

; Editor -> Editor
; moves the cursor position one 1String left, 
; if possible 
(define (editor-lft ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [else (make-editor (rest (editor-pre ed)) (cons (first (editor-pre ed)) (editor-post ed)))]))
(check-expect
  (editor-lft (create-editor "cd" "fgh"))
  (create-editor "c" "dfgh"))
(check-expect
  (editor-lft (create-editor "" "cdfgh"))
  (create-editor "" "cdfgh"))

; Editor -> Editor
; moves the cursor position one 1String right, 
; if possible 
(define (editor-rgt ed)
    (cond
    [(empty? (editor-post ed)) ed]
    [else (make-editor (cons (first (editor-post ed)) (editor-pre ed)) (rest (editor-post ed)))]))
(check-expect
  (editor-rgt (create-editor "cd" "fgh"))
  (create-editor "cdf" "gh"))
(check-expect
  (editor-rgt (create-editor "cdfgh" ""))
  (create-editor "cdfgh" ""))

; Editor -> Editor
; deletes a 1String to the left of the cursor,
; if possible 
(define (editor-del ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [else (make-editor (rest (editor-pre ed)) (editor-post ed))]))
(check-expect
  (editor-del (create-editor "cd" "fgh"))
  (create-editor "c" "fgh"))
(check-expect
  (editor-del (create-editor "" "fgh"))
  (create-editor "" "fgh"))

; Editor -> Image
(define (editor-render ed)
  (place-image/align
    (beside (editor-text (reverse (editor-pre ed)))
            CURSOR
            (editor-text (editor-post ed)))
    1 1
    "left" "top"
    MT))

; Lo1s -> Image
; renders a list of 1Strings as a text image 
(define (editor-text s)
  (cond
    [(empty? s) (text "" FONT-SIZE FONT-COLOR)]
    [else (beside  (text (first s) FONT-SIZE FONT-COLOR) (editor-text (rest s)))]))

(check-expect
  (editor-text
   (cons "p" (cons "o" (cons "s" (cons "t" '())))))
  (text "post" FONT-SIZE FONT-COLOR))

; main : String -> Editor
; launches the editor given some initial string 
(define (main s)
   (big-bang (create-editor s "")
     [on-key editor-kh]
     [to-draw editor-render]))