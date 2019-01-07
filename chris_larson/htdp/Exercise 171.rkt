;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 171|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; A List-of-strings is one of
; --'()
; --(cons String List-of-strings)

(cons "  TTT"
(cons ""
(cons "  "
(cons ""
(cons "  Put up in a place"
(cons ""
(cons "  where it's easy to see"
(cons ""
(cons "  the cryptic admonishment"
(cons ""
(cons "  T.T.T."
(cons ""
(cons "  "
(cons ""
(cons "  When you feel how depressingly"
(cons ""
(cons "  slowly you climb,"
(cons ""
(cons "  it's well to remember that"
(cons ""
(cons "  Things Take Time."
(cons ""
(cons "  "
(cons ""
(cons "  Piet Hein" '())))))))))))))))))))))))))

(read-lines "ttt.txt")
(read-words "ttt.txt")

; A List-list-of-strings is one of
; --'()
; --(cons List-of-strings List-list-of-strings)

(read-words/line "ttt.txt")

; LLS -> List-of-numbers
; determines the number of words on each line 
(define (words-on-line lls)
  (cond
    [(empty? lls) '()]
    [else (cons (length (first lls))
                (words-on-line (rest lls)))]))

(define line0 (cons "hello" (cons "world" '())))
(define line1 '())
 
(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))

(check-expect (words-on-line lls0) '())
(check-expect (words-on-line lls1)
              (cons 2 (cons 0 '())))

; String -> List-of-numbers
; counts the words on each line in the given file
(define (file-statistic file-name)
  (words-on-line
    (read-words/line file-name)))


