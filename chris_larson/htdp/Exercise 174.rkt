;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 174|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; 1String -> String
; converts the given 1String to a 3-letter numeric String
 
(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t")
              (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a")
              (string-append "0" (code1 "a")))
 
(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10)
     (string-append "00" (code1 s))]
    [(< (string->int s) 100)
     (string-append "0" (code1 s))]))
 
; 1String -> String
; converts the given 1String into a String
 
(check-expect (code1 "z") "122")
 
(define (code1 c)
  (number->string (string->int c)))

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

; String -> File
; opens filename, encodes 1Strings to Numbers, saves file
(define (encode-file n)
  (write-file (string-append "encoded-" n) (collapse (encode (read-words/line n)))))

; List-list-of-string -> List-list-of-string
; replaces all 1Strings with 3 Letter numeric string
(define (encode llos)
  (cond
    [(empty? llos) '()]
    [else (cons (encode-line (first llos)) (encode (rest llos)))]))
(check-expect (encode (cons (cons "hello" (cons "world" '())) (cons (cons "hello" (cons "world" '())) '())))
              (cons (cons "104101108108111" (cons "119111114108100" '())) (cons (cons "104101108108111" (cons "119111114108100" '())) '())))
              
; List-of-string -> List-of-string
; replaces all 1Strings with 3 Letter numeric string
(define (encode-line los)
  (cond
    [(empty? los) '()]
    [else (cons (encode-word (explode (first los))) (encode-line (rest los)))]))
(check-expect (encode-line (cons "hello" (cons "world" '()))) (cons "104101108108111" (cons "119111114108100" '())))
                                                               
; List-of 1String -> String
; encodes each letter of word
(define (encode-word lo1s)
  (cond
    [(empty? lo1s) ""]
    [else (string-append (encode-letter (first lo1s)) (encode-word (rest lo1s)))]))
(check-expect (encode-word (explode "hello")) (string-append (encode-letter "h") (encode-letter "e") (encode-letter "l") (encode-letter "l") (encode-letter "o")))
(check-expect (encode-word (explode "world")) (string-append (encode-letter "w") (encode-letter "o") (encode-letter "r") (encode-letter "l") (encode-letter "d")))

; String -> String
; counts 1strings, words and lines
(define (wc n)
  (counts (read-words/line n)))

; List-list-of-strings -> String
; Counts 1Strings, words and lines
(define (counts llos)
  (string-append "l:" (line-count llos)))

; List-list-of-string
; returns line count
(define (line-count llos)
  (cond
    [(empty? llos) 0]
    [else (+ 1 (line-count (rest llos)))]))
(check-expect (line-count (cons (cons " " '()) (cons (cons " " '()) (cons " " '())))) 3)
(check-expect (line-count (read-words/line "ttt.txt")) 27)