;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 173|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; String -> File
; opens filename, removes articles, saves file
(define (file-remove-articles n)
  (write-file "ta.dat" (collapse (remove-articles (read-words/line n)))))

; List-of-strings -> String
; removes articles from los
(define (line-remove-articles los)
  (cond
    [(empty? los) '()]
    [(or (string=? (first los) "a") (string=? (first los) "an") (string=? (first los) "the"))(line-remove-articles (rest los))]
    [else (cons (first los) (line-remove-articles (rest los)))]))

; List-list-of-string
; remove articles from each line
(define (remove-articles llos)
  (cond
    [(empty? llos) '()]
    [else (cons (line-remove-articles (first llos)) (remove-articles (rest llos)))]))

; List-of-lines -> string
; concats a list of list-of-strings into a single string
(define (collapse lol)
  (cond
    [(empty? lol) ""]
    [else (string-append (collapse-line (first lol)) (if (empty? (rest lol)) "" "\n") (collapse (rest lol)))]))
(check-expect (collapse (read-words/line "ttt.txt")) "TTT\n\n\n\nPut up in a place\n\nwhere it's easy to see\n\nthe cryptic admonishment\n\nT.T.T.\n\n\n\nWhen you feel how depressingly\n\nslowly you climb,\n\nit's well to remember that\n\nThings Take Time.\n\n\n\nPiet Hein\n\n")

; List-of-strings -> string
; combines los to a single string separated by " "
(define (collapse-line los)
  (cond
    [(empty? los) ""]
    [else (string-append (first los) (if (empty? (rest los)) "" " ") (collapse-line (rest los)))]))
(check-expect (collapse-line (cons "the" (cons "cryptic" (cons "admonishment" '())))) "the cryptic admonishment")