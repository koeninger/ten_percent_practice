;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10_more_lists) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/batch-io)
(require 2htdp/universe)


; List-of-numbers -> List-of-numbers
; computes the weekly wages for all given weekly hours
(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons 392 '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons 56 (cons 28 '())))
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (if (> (first whrs) 100)
              (error "too many hours")
              (cons (wage (first whrs)) (wage* (rest whrs))))]))
 
; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* 14 h))

; Number -> Number 
; converts Fahrenheit temperatures to Celsius
; given 32, expect 0
; given 212, expect 100
; given -40, expect -40
(define (f2c f)
  (* 5/9 (- f 32)))

; list-of-number -> list-of-number
; convert list of fahrenheit to list of celsius
(check-expect (convertFC '()) '())
(check-expect (convertFC (list 32)) (list 0))
(check-expect (convertFC (list 32 41)) (list 0 5))
(define (convertFC fs)
  (cond
    [(empty? fs) '()]
    [else (cons (f2c (first fs)) (convertFC (rest fs)))]))

; number list-of-number -> list-of-number
; given exchange rate and list of dollars, return list of euros
(check-expect (convert-euro* 0 '()) '())
(check-expect (convert-euro* 1.16 (list 10 20)) (list 11.6 23.2))
(define (convert-euro* r ds)
  (cond
    [(empty? ds) '()]
    [else (cons (* r (first ds)) (convert-euro* r (rest ds)))]))

; list-of-string -> list-of-string
; replace robot with r2d2
(check-expect (subst-robot '()) '())
(check-expect (subst-robot (list "bob" "robot" "ted")) (list "bob" "r2d2" "ted"))
(define (subst-robot rs)
  (cond
    [(empty? rs) '()]
    [else (cons (if (string=? "robot" (first rs))
                    "r2d2"
                    (first rs))
                (subst-robot (rest rs)))]))

; string string list-of-string -> list-of-string
; replace old with new in list of strings
(check-expect (substitute  "robot" "r2d2" '()) '())
(check-expect (substitute "robot" "c3p0" (list "bob" "robot" "ted")) (list "bob" "c3p0" "ted"))
(define (substitute old new rs)
  (cond
    [(empty? rs) '()]
    [else (cons (if (string=? old (first rs))
                    new
                    (first rs))
                (substitute old new (rest rs)))]))

(define-struct work [employee rate hours])
; A (piece of) Work is a structure: 
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name 
; with the pay rate r and the number of hours h

; Low -> List-of-numbers
; computes the weekly wages for all weekly work records  
(check-expect
  (wage*.v2 (cons (make-work "Robby" 11.95 39) '()))
  (cons (* 11.95 39) '()))
(define (wage*.v2 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v2 (first an-low))
                          (wage*.v2 (rest an-low)))]))
 
; Work -> Number
; computes the wage for the given work record w
(define (wage.v2 w)
  (* (work-rate w) (work-hours w)))

(define-struct paycheck [employee amount])
; employee and amount


; Low -> List-of-paycheck
; computes the weekly wages for all weekly work records  
(check-expect
  (wage*.v3 (cons (make-work "Robby" 11.95 39) '()))
  (cons (make-paycheck "Robby" (* 11.95 39)) '()))
(define (wage*.v3 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v3 (first an-low))
                          (wage*.v3 (rest an-low)))]))
 
; Work -> Paycheck
; computes the wage for the given work record w
(define (wage.v3 w)
  (make-paycheck (work-employee w) (* (work-rate w) (work-hours w))))

(define-struct employee [name number])
; employee name and serial number

; Low -> List-of-paycheck
; computes the weekly wages for all weekly work records
; uses employee struct
(check-expect
  (wage*.v4 (cons (make-work (make-employee "Robby" 666) 11.95 39) '()))
  (cons (make-paycheck (make-employee "Robby" 666) (* 11.95 39)) '()))
(define (wage*.v4 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v4 (first an-low))
                          (wage*.v4 (rest an-low)))]))
 
; Work -> Paycheck
; computes the wage for the given work record w
(define (wage.v4 w)
  (make-paycheck (work-employee w) (* (work-rate w) (work-hours w))))


; list-of-posn -> number
; sum of x coordinates
(check-expect (sum (list (make-posn 1 23) (make-posn 2 42))) 3)
(define (sum ps)
  (cond
    [(empty? ps) 0]
    [(cons? ps) (+ (posn-x (first ps)) (sum (rest ps)))]))

; list-of-posn -> list-of-posn
; add 1 to each y coord
(check-expect (translate (list (make-posn 23 1) (make-posn 42 2))) (list (make-posn 23 2) (make-posn 42 3)))
(define (translate ps)
  (cond
    [(empty? ps) '()]
    [(cons? ps) (cons (make-posn (posn-x (first ps)) (+ 1 (posn-y (first ps)))) (translate (rest ps)))]))


; list-of-posn -> list-of-posn
; all those Posns whose x-coordinates are between 0 and 100 and whose y-coordinates are between 0 and 200
(check-expect (legal (list (make-posn -1 23) (make-posn 1 1) (make-posn 23 201)))
              (list (make-posn 1 1)))
(define (legal ps)
  (cond
    [(empty? ps) '()]
    [(cons? ps)
     (if (and (<= 0 (posn-x (first ps))) (<= (posn-x (first ps)) 100)
              (<= 0 (posn-y (first ps))) (<= (posn-y (first ps)) 200))
         (cons (first ps) (legal (rest ps)))
         (legal (rest ps)))]))

(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999. 
; A Four is a Number between 1000 and 9999. 

; list-of-phone -> list-of-phone
; replace 713 area code with 281
(check-expect (replace (list (make-phone 712 555 1212) (make-phone 713 555 1212)))
              (list (make-phone 712 555 1212) (make-phone 281 555 1212)))
(define (replace ps)
  (cond
    [(empty? ps) '()]
    [(cons? ps)
     (cons (make-phone (if (= 713 (phone-area (first ps))) 281 (phone-area (first ps)))
                       (phone-switch (first ps))
                       (phone-four (first ps)))
           (replace (rest ps)))]))

; ex 173

; a list-of-strings is either '() or (cons "somestring" a-list-of-strings)

(check-expect (read-lines "ttt.txt")
              (list
               ""
               "TTT"
               ""
               "Put up in a place"
               "where it's easy to see"
               "the cryptic admonishment"
               "T.T.T."
               ""
               "When you feel how depressingly"
               "slowly you climb,"
               "it's well to remember that"
               "Things Take Time."
               ""
               "Piet Hein"))

(check-expect (read-words "ttt.txt")
(list
 "TTT"

"Put" "up" "in" "a" "place"
"where" "it's" "easy" "to" "see"
"the" "cryptic" "admonishment"
"T.T.T."

"When" "you" "feel" "how" "depressingly"
"slowly" "you" "climb,"
"it's" "well" "to" "remember" "that"
"Things" "Take" "Time."

"Piet" "Hein"))

; a list-of-list-of-strings is either '() or (cons a-list-of-string a-list-of-list-of-strings

(define PIET-LOL
  (list
       '()
       (list "TTT")
       '()
       (list "Put" "up" "in" "a" "place")
       (list "where" "it's" "easy" "to" "see")
       (list "the" "cryptic" "admonishment")
       (list "T.T.T.")
       '()
       (list "When" "you" "feel" "how" "depressingly")
       (list "slowly" "you" "climb,")
       (list "it's" "well" "to" "remember" "that")
       (list "Things" "Take" "Time.")
       '()
       (list "Piet" "Hein")))

(check-expect (read-words/line "ttt.txt") PIET-LOL)
      


; ex 172

; list-of-lines -> string
; converts lines into single string, each line separated by spaces

(check-expect (collapse (list (list "a" "quick" "brown" "fox")
                              (list "jumped over")))
              "a quick brown fox\njumped over")
(define (collapse xs)
  (cond
    [(empty? xs) ""]
    [(eq? (rest xs) '()) (collapse-line (first xs))]
    [(cons? xs) (string-append (collapse-line (first xs)) "\n" (collapse (rest xs)))]))
(define (collapse-line xs)
  (cond
    [(empty? xs) ""]
    [(eq? (rest xs) '()) (first xs)]
    [(cons? xs) (string-append (first xs) " " (collapse-line (rest xs)))]))

(define ARTICLES (list "a" "an" "the"))

; filename -> new filename + side effect of writing
; remove any word in ARTICLES from text in filename from, write it out to filename prepended with "no-articles-"
(define (remove-articles-file from)
  (write-file (string-append "no-articles-" from)
              (collapse (remove-articles (read-words/line from)))))

; list-of-lines -> list-of-lines
; remove any word in ARTICLES from list-of-lines in
(check-expect (remove-articles PIET-LOL)
              (list
               '()
               (list "TTT")
               '()
               (list "Put" "up" "in" "place")
               (list "where" "it's" "easy" "to" "see")
               (list "cryptic" "admonishment")
               (list "T.T.T.")
               '()
               (list "When" "you" "feel" "how" "depressingly")
               (list "slowly" "you" "climb,")
               (list "it's" "well" "to" "remember" "that")
               (list "Things" "Take" "Time.")
               '()
               (list "Piet" "Hein")))
(define (remove-articles in)
  (cond
    [(empty? in) '()]
    [(cons? in) (cons (remove* ARTICLES (first in)) (remove-articles (rest in)))]))

; list list -> list
; remove from in any item in set
(check-expect (remove* (list 1 2 3) (list 1 4 2 3 5)) (list 4 5))
(define (remove* set in)
  (cond
    [(empty? in) '()]
    [(cons? in) (if (member (first in) set)
                    (remove* set (rest in))
                    (cons (first in) (remove* set (rest in))))]))


; ex 174

; 1String -> String
; converts the given 1String to a 3-letter numeric String
 
(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t")
              (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a")
              (string-append "0" (code1 "a")))

; handle whether the ascii value of a character has 1, 2 or 3 digits
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

; the ascii value of character c
(define (code1 c)
  (number->string (string->int c)))

; filename -> new filename + side effect of writing
; numerically encode file from to new file with name prefixed "encoded-" 
(define (encode-file from)
  (write-file (string-append "encoded-" from)
              (collapse (encode-lines (read-words/line from)))))

; list-of-lines -> list-of-lines
; encode characters in lol
(check-expect (encode-lines (list (list "a" "foo")
                                (list "bar")))
              (list (list "097" "032" "102" "111" "111" )
                    (list "098" "097" "114")))
(define (encode-lines lol)
  (cond
    [(empty? lol) '()]
    [(cons? lol) (cons (encode-l (explode* (first lol))) (encode-lines (rest lol)))]))
; list-of-string -> list-of-char
; convert list of string to list of char, re-includes spaces
(define (explode* xs)
  (cond
    [(empty? xs) '()]
    [(empty? (rest xs)) (explode (first xs))]
    [(cons? xs) (append (explode (first xs)) (list " ") (explode* (rest xs)))]))
; list-of-char -> list-of-string
; encode each char in cs
(define (encode-l cs)
  (cond
    [(empty? cs) '()]
    [(cons? cs) (cons (encode-letter (first cs)) (encode-l (rest cs)))]))


; ex 176

; A Matrix is one of: 
;  – (cons Row '())
;  – (cons Row Matrix)
; constraint all rows in matrix are of the same length
 
; A Row is one of: 
;  – '() 
;  – (cons Number Row)

(define example-two-by-two
  (list
   (list 11 12)
   (list 21 22)))

(define transposed-example-two-by-two
  (list
   (list 11 21)
   (list 12 22)))

; Matrix -> Matrix
; transposes the given matrix along the diagonal 
  
(check-expect (transpose example-two-by-two) transposed-example-two-by-two)
 
(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
    [else (cons (first* lln) (transpose (rest* lln)))]))

; matrix -> list
; first column in the matrix
(check-expect (first* example-two-by-two) (list 11 21))
(define (first* m)
  (cond
    [(and (cons? m) (cons? (first m)))
     (cons (first (first m)) (first* (rest m)))]
    [else '()]))

; matrix -> matrix
; all but the first column in the matrix
(check-expect (rest* example-two-by-two) (list (list 12) (list 22)))
(define (rest* m)
  (cond
    [(and (cons? m) (cons? (first m)))
     (cons (rest (first m)) (rest* (rest m)))]
    [else '()]))

; Lo1s -> Lo1s 
; produces a reverse version of the given list 
(check-expect
  (rev (cons "a" (cons "b" (cons "c" '()))))
  (cons "c" (cons "b" (cons "a" '()))))
(define (rev l)
  (cond
    [(empty? l) '()]
    [(cons? l) (append (rev (rest l)) (list (first l)))]))


; ex 177

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; where pre is reversed
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)


; string string -> editor
; create an editor
(check-expect (create-editor (list "a" "b") (list "c" "d"))
              (make-editor (list "b" "a") (list "c" "d")))
(define (create-editor pre post)
  (make-editor (rev pre) post))

(define HEIGHT 20) ; the height of the editor 
(define WIDTH 200) ; its width 
(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color 
 
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))

; ex 178
; it handles \t and \r first because they are strings of length 1, but should be ignored

; Editor -> Image
; renders an editor as an image of the two texts 
; separated by the cursor 
(define (editor-render e) MT)
 
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

(check-expect
  (editor-ins (make-editor '() '()) "e")
  (make-editor (cons "e" '()) '())) 
(check-expect
  (editor-ins
    (make-editor (cons "d" '())
                 (cons "f" (cons "g" '())))
    "e")
  (make-editor (cons "e" (cons "d" '()))
               (cons "f" (cons "g" '()))))
(define (editor-ins ed k)
  (make-editor (cons k (editor-pre ed))
               (editor-post ed)))

; Editor -> Editor
; moves the cursor position one 1String left, 
; if possible
(check-expect (editor-lft  (make-editor (list "b" "a") (list "c" "d")))
              (make-editor (list "a") (list "b" "c" "d")))
(check-expect (editor-lft (make-editor '() '()))
              (make-editor '() '()))
(define (editor-lft ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [(cons? (editor-pre ed))
     (make-editor (rest (editor-pre ed)) (cons (first (editor-pre ed)) (editor-post ed)))]))
 
; Editor -> Editor
; moves the cursor position one 1String right, 
; if possible
(check-expect (editor-rgt  (make-editor (list "b" "a") (list "c" "d")))
              (make-editor (list "c" "b" "a") (list "d")))
(check-expect (editor-rgt (make-editor '() '()))
              (make-editor '() '()))
(define (editor-rgt ed)
  (cond
    [(empty? (editor-post ed)) ed]
    [(cons? (editor-post ed))
     (make-editor (cons (first (editor-post ed)) (editor-pre ed)) (rest (editor-post ed)))]))

; Editor -> Editor
; deletes a 1String to the left of the cursor,
; if possible
(check-expect (editor-del  (make-editor (list "b" "a") (list "c" "d")))
              (make-editor (list "a") (list "c" "d")))
(check-expect (editor-del (make-editor '() '()))
              (make-editor '() '()))
(define (editor-del ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [(cons? (editor-pre ed))
     (make-editor (rest (editor-pre ed)) (editor-post ed))]))

; main : String -> Editor
; launches the editor given some initial string 
(define (main s)
   (big-bang (create-editor s "")
     [on-key editor-kh]
     [to-draw editor-render]))