(require 2htdp/batch-io)

; 10.1 Functions that Produce Lists

; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* 12 h))

; List-of-numbers -> List-of-numbers
; computes the weekly wages for all given weekly hours
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (cons (wage (first whrs)) (wage* (rest whrs)))]))


; Exercise 161.
(check-expect (wage* '()) '())
(check-expect (wage* (list 28))(list 336))
(check-expect (wage* (list 4 2)) (list 48 24))


; Exercise 162.
(define ERR-MSG "No employee could possibly work more than 100 hours per week.")

; List-of-numbers -> List-of-numbers
; computes the weekly wages for all given weekly hours
(check-expect (check-wage* '()) '())
(check-error (check-wage* (list 28))ERR-MSG)
(check-expect (check-wage* (list 4 2)) (list 48 24))
(define (check-wage* whrs)
  (cond
    [(empty? whrs) '()]
    [(> (wage (first whrs)) 100) (error ERR-MSG)]
    [else (cons (wage (first whrs)) (wage* (rest whrs)))]))


; Exercise 163.

; List-of-Temps-in-Fahrenheit -> List-of-Temps-in-Celsius
; converts a list of measurements in Fahrenheit to a list of Celsius measurements
(check-expect (convertFC '()) '())
(check-expect (convertFC (list 32 212 -40)) (list 0 100 -40))
(define (convertFC temps)
  (cond
    [(empty? temps) '()]
    [else (cons (C (first temps)) (convertFC (rest temps)))]))

; Temperature (Fahrenheit) -> Temperature (Celsius)
; converts a measurement in Fahrenheit to a Celsius measurement
(check-expect (C 32) 0)
(check-expect (C 212) 100)
(check-expect (C -40) -40)
(define (C f)
  (* 5/9 (- f 32)))


; Exercise 164.

(define EURO-RATE 0.88)

; List-of-US-amounts -> List-of-Euro-amounts
; converts a list of US$ amounts into a list of € amounts
(check-expect (convert-euro '()) '())
(check-expect (convert-euro (list 1)) (list EURO-RATE))
(check-expect (convert-euro (list 0 1 20)) (list 0 EURO-RATE (* EURO-RATE 20)))
(define (convert-euro ua)
  (cond
    [(empty? ua) '()]
    [else (cons (* (first ua) EURO-RATE) (convert-euro (rest ua)))]))

; Number, List-of-US-amounts -> List-of-Euro-amounts
; consumes an exchange rate and a list of US$ amounts and converts the latter into a list of € amounts
(check-expect (convert-euro* EURO-RATE '()) '())
(check-expect (convert-euro* 0.5 (list 1)) (list 0.5))
(check-expect (convert-euro* 1 (list 0 1 20)) (list 0 1 20))
(define (convert-euro* er ua)
  (cond
    [(empty? ua) '()]
    [else (cons (* (first ua) er) (convert-euro* er (rest ua)))]))


; Exercise 165

(check-expect (subst-robot '()) '())
(check-expect (subst-robot (list "test")) (list "test"))
(check-expect (subst-robot (list "robot")) (list "r2d2"))
(check-expect (subst-robot (list "test" "robot")) (list "test" "r2d2"))
(define (subst-robot toys)
  (cond
    [(empty? toys) '()]
    [else (cons (if (string=? "robot" (first toys)) "r2d2" (first toys)) (subst-robot (rest toys)))]))

(check-expect (substitute "robot" "r2d2" '()) '())
(check-expect (substitute "robot" "r2d2" (list "test")) (list "test"))
(check-expect (substitute "robot" "r2d2" (list "robot")) (list "r2d2"))
(check-expect (substitute "test" "prod" (list "test" "robot")) (list "prod" "robot"))
(define (substitute old new strings)
  (cond
    [(empty? strings) '()]
    [else (cons (if (string=? old (first strings)) new (first strings)) (substitute old new (rest strings)))]))


; 10.2 Structures in Lists

(define-struct work [employee rate hours])
; A (piece of) Work is a structure:
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name
; with the pay rate r and the number of hours h

; Low (short for list of works) is one of:
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the
; hours worked for a number of employees

; Low -> List-of-numbers
; computes the weekly wages for the given records
(define (wage*.v2 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v2 (first an-low))
                          (wage*.v2 (rest an-low)))]))
(check-expect (wage*.v2 (list (make-work "Robby" 11.95 39))) (list (* 11.95 39)))

; Work -> Number
; computes the wage for the given work record w
(define (wage.v2 w)
  (* (work-rate w) (work-hours w)))


; Exercise 166.

(define-struct paycheck [name amount])
; A paycheck is a structure:
;   (make-paycheck String Number)
; interpretation (make-paycheck n a) combines the name
; with the amount of pay for that employee

; Low -> List-of-numbers
; computes the weekly wages for the given records
(check-expect (wage*.v3
    (list (make-work "Robby" 11.95 39)))
  (list (make-paycheck "Robby" (* 11.95 39))))
(define (wage*.v3 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (make-paycheck (work-employee (first an-low)) (wage.v2 (first an-low)))
                          (wage*.v3 (rest an-low)))]))

(define-struct work.v4 [id employee rate hours])
; A (piece of) Work.v2 is a structure:
;   (make-work Number String Number Number)
; interpretation (make-work i n r h) combines the id
; and name with the pay rate r and the number of hours h

; Work -> Number
; computes the wage for the given work record w
(define (wage.v4 w)
  (* (work.v4-rate w) (work.v4-hours w)))

(define-struct paycheck.v4 [id name amount])
; A paycheck is a structure:
;   (make-paycheck String Number)
; interpretation (make-paycheck n a) combines the id and
; name with the amount of pay for that employee

; Low -> List-of-numbers
; computes the weekly wages for the given records
(check-expect (wage*.v4
    (list (make-work.v4 1 "Robby" 11.95 39)))
  (list (make-paycheck.v4 1 "Robby" (* 11.95 39))))
(define (wage*.v4 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (make-paycheck.v4
                            (work.v4-id (first an-low))
                            (work.v4-employee (first an-low))
                            (wage.v4 (first an-low)))
                          (wage*.v4 (rest an-low)))]))


; Exercise 167.

; An ALOP is one of:
; – '()
; – (cons Posn ALOP)
; interpretation represents a list of Posn

; ALOP -> Number
; consumes a list of Posn and produces the sum of all of its x-coordinates
(check-expect (sum '()) 0)
(check-expect (sum (list (make-posn 5 10))) 5)
(check-expect (sum (list (make-posn 1 5) (make-posn 5 10))) 6)
(define (sum alop)
  (cond
    [(empty? alop) 0]
    [else (+ (posn-x (first alop)) (sum (rest alop)))]))


; Exercise 168.

; ALOP -> ALOP
; for each (make-posn x y) it consumes, it returns (make-posn x (+ y 1))
(check-expect (translate* '()) '())
(check-expect (translate* (list (make-posn 5 10))) (list (make-posn 5 11)))
(check-expect (translate* (list (make-posn 1 5) (make-posn 5 10))) (list (make-posn 1 6) (make-posn 5 11)))
(define (translate* alop)
  (cond
    [(empty? alop) '()]
    [else (cons (translate (first alop)) (translate* (rest alop)))]))

; posn -> posn
; translates a single Posn
(define (translate p)
  (make-posn (posn-x p) (+ (posn-y p) 1)))


; Exercise 169.

; ALOP -> ALOP
; result contains all those Posns whose x-coordinates are
; between 0 and 100 and whose y-coordinates are between 0 and 200
(check-expect (legal '()) '())
(check-expect (legal (list (make-posn 101 10))) '())
(check-expect (legal (list (make-posn 1 5) (make-posn 5 201))) (list (make-posn 1 5)))
(define (legal alop)
  (cond
    [(empty? alop) '()]
    [(legal? (first alop)) (cons (first alop) (legal (rest alop)))]
    [else (legal (rest alop))]))

; posn -> posn
; returns Posns if x-coordinates are between 0 and 100 and whose
; y-coordinates are between 0 and 200 for a single Posn, else '()
(define (legal? p)
  (and
     (>= (posn-x p) 0)
     (<= (posn-x p) 100)
     (>= (posn-y p) 0)
     (<= (posn-y p) 200)))


; Exercise 170.

; An ALOP is one of:
; – '()
; – (cons Phone '())
; interpretation represents a list of phone numbers

(define-struct phone [area switch four])
; A Phone is a structure:
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999.
; A Four is a Number between 1000 and 9999.

; ALOP -> ALOP
; replaces all occurrence of area code 713 with 281
(check-expect (replace* '()) '())
(check-expect (replace* (list (make-phone "310" "555" "1234"))) (list (make-phone "310" "555" "1234")))
(check-expect (replace* (list (make-phone "713" "555" "1234"))) (list (make-phone "281" "555" "1234")))
(define (replace* alop)
  (cond
    [(empty? alop) '()]
    [else (cons (replace (first alop)) (replace* (rest alop)))]))


; Phone -> Phone
; replaces the occurrence of area code 713 with 281
(define (replace p)
  (make-phone
    (if (string=? (phone-area p) "713")
        "281" (phone-area p))
    (phone-switch p)
    (phone-four p)))


; Exercise 171.

; A List-of-strings is one of:
; – '()
; – (cons String List-of-strings)
; interpretation represents a list of String
(define los1
  (cons  "TTT"
    (cons ""
      (cons "Put up in a place"
        (cons "where it's easy to see"
          (cons "the cryptic admonishment"
            (cons "T.T.T."
              (cons  ""
                (cons "When you feel how depressingly"
                  (cons "slowly you climb,"
                    (cons "it's well to remember that"
                      (cons "Things Take Time."
                        (cons ""
                          (cons "Piet Hein" '()))))))))))))))

(define los2
  (cons  "TTT"
    (cons ""
      (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place"
        (cons "where" (cons "it's" (cons "easy" (cons "to" (cons "see"
          (cons "the" (cons "cryptic" (cons "admonishment"
            (cons "T.T.T."
              (cons  ""
                (cons "When" (cons "you" (cons "feel" (cons "how" (cons "depressingly"
                  (cons "slowly" (cons "you" (cons "climb,"
                    (cons "it's" (cons "well" (cons "to" (cons "remember" (cons "that"
                      (cons "Things" (cons "Take" (cons "Time."
                        (cons ""
                          (cons "Piet" (cons "Hein" '())))))))))))))))))))))))))))))))))))))

; A List-of-list-of-strings is one of:
; – '()
; – (cons List-of-strings List-of-list-of-strings)
; interpretation represents a list of List-of-strings
(define lolos
  (list
    (cons "TTT" '())
    (cons "" '())
    (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" '())))))
    (cons "where" (cons "it's" (cons "easy" (cons "to" (cons "see" '())))))
    (cons "the" (cons "cryptic" (cons "admonishment" '())))
    (cons "T.T.T." '())
    (cons "" '())
    (cons "When" (cons "you" (cons "feel" (cons "how" (cons "depressingly" '())))))
    (cons "slowly" (cons "you" (cons "climb," '())))
    (cons "it's" (cons "well" (cons "to" (cons "remember" (cons "that" '())))))
    (cons "Things" (cons "Take" (cons "Time." '())))
    (cons "" '())
    (cons "Piet" (cons "Hein" '()))))


; Exercise 172.

; List-of-list-of-strings -> String
; converts a list of lines into a string.
(check-expect (collapse lolos)
  "TTT \n \nPut up in a place \nwhere it's easy to see \nthe cryptic admonishment \nT.T.T. \n \nWhen you feel how depressingly \nslowly you climb, \nit's well to remember that \nThings Take Time. \n \nPiet Hein \n")
(define (collapse lls)
  (cond
    [(empty? lls) ""]
    [else (string-append (collapse-line (first lls)) "\n" (collapse (rest lls)))]))

; List-of-strings -> String
; converts a list of lines into a string.
(check-expect (collapse-line (list "Hello," "World!")) "Hello, World! ")
(define (collapse-line ls)
  (cond
    [(empty? ls) ""]
    [else (string-append (first ls) " " (collapse-line (rest ls)))]))


; Exercise 173.

; String -> String
; consumes the name n of a file, reads the file, removes the articles, and writes the
; result out to a file whose name is the result of concatenating "no-articles-" with n
(check-expect (remove-articles-file "TTT.txt") "no-articles-TTT.txt")
(define (remove-articles-file n)
  (write-file (string-append "no-articles-" n) (remove-articles* (read-words/line n))))

; List-of-list-of-strings -> String
; consumes a List-of-list-of-strings, removes the articles, and returns as string
(check-expect (remove-articles* '()) "")
(check-expect (remove-articles* (list (list ""))) "\n")
(check-expect (remove-articles* (list (list "a"))) "")
(check-expect (remove-articles* (list (list "Hello,") (list "World!"))) "Hello,\nWorld!\n")
(check-expect (remove-articles* (list (list "Hello,") (list "an") (list "World!"))) "Hello,\nWorld!\n")
(define (remove-articles* lls)
  (cond
    [(empty? lls) ""]
    [else (string-append (remove-articles (first lls)) (remove-articles* (rest lls)))]))

; List-of-strings -> String
; removes the articles from each string in List-of-strings
(check-expect (remove-articles '()) "")
(check-expect (remove-articles (list "")) "\n")
(check-expect (remove-articles (list "a")) "")
(check-expect (remove-articles (list "Hello," "World!")) "Hello, World!\n")
(check-expect (remove-articles (list "Hello," "the" "World!")) "Hello, World!\n")
(define (remove-articles ls)
  (cond
    [(empty? ls) ""]
    [(is-article? (first ls)) (remove-articles (rest ls))]
    [else (string-append (first ls) (if (empty? (rest ls)) "\n" " ") (remove-articles (rest ls)))]))

; String -> Boolean
; determines if string is an article (an article is one of the following three words: "a", "an", and "the")
(check-expect (is-article? "") #false)
(check-expect (is-article? "a") #true)
(check-expect (is-article? "an") #true)
(check-expect (is-article? "the") #true)
(check-expect (is-article? "test") #false)
(define (is-article? w)
  (cond
    [(string=? w "a") #true]
    [(string=? w "an") #true]
    [(string=? w "the") #true]
    [else #false]))


; Exercise 174.

; 1String -> String
; converts the given 1String to a 3-letter numeric String
(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t") (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a") (string-append "0" (code1 "a")))
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

; String -> String
; encodes text files numerically. Each letter in a word should be encoded
; as a numeric three-letter string with a value between 0 and 256.
(check-expect (encode-file "TTT.txt")
  "084084084080117116117112105110097112108097099101119104101114101105116039115101097115121116111115101101116104101099114121112116105099097100109111110105115104109101110116084046084046084046087104101110121111117102101101108104111119100101112114101115115105110103108121115108111119108121121111117099108105109098044105116039115119101108108116111114101109101109098101114116104097116084104105110103115084097107101084105109101046080105101116072101105110")
(define (encode-file n)
  (encode-list (read-words/line n)))

; List-of-list-of-strings -> String
; encodes a List-of-list-of-strings numerically. Each letter in a word should
; be encoded as a numeric three-letter string with a value between 0 and 256.
(check-expect (encode-list (list (list "Hello," '() "World!")))
  "072101108108111044087111114108100033")
(define (encode-list lls)
  (cond
    [(empty? lls) ""]
    [else (string-append (encode-words (first lls)) (encode-list (rest lls)))]))

; List-of-strings -> String
; encodes a List-of-strings numerically. Each letter in a word should
; be encoded as a numeric three-letter string with a value between 0 and 256.
(check-expect (encode-words (list "Hello," "World!"))
  "072101108108111044087111114108100033")
(define (encode-words ls)
  (cond
    [(empty? ls) ""]
    [(empty? (first ls)) (encode-words (rest ls))]
    [else (string-append (encode-word (explode (first ls))) (encode-words (rest ls)))]))

; String -> String
; encodes a String numerically. Each letter in a word should
; be encoded as a numeric three-letter string with a value between 0 and 256.
(check-expect (encode-word (list "t" "e" "s" "t")) "116101115116")
(define (encode-word w)
  (cond
    [(empty? w) ""]
    [else (string-append (encode-letter (first w)) (encode-word (rest w)))]))


; Exercise 175.

(define-struct word-count [letters words lines])
; A Word-Count is a structure:
;   (make-work Number Number Number)
; interpretation (make-word-count s w l) where s is the
;   number of 1Strings, w the words, and l the lines

; String -> Word-Count
; consumes the name of a file and produces a Word-Count
(check-expect (wc "ttt.txt") (make-word-count 148 33 13))
(define (wc n)
  (make-word-count
    (count-letters* (read-words/line n))
    (count-words (read-words/line n))
    (count-list (read-words/line n))))

; List -> Numbers
; counts the number of elements in a List
(check-expect (count-list '()) 0)
(check-expect (count-list (list "test")) 1)
(check-expect (count-list (list (list "Hello,") (list "World!"))) 2)
(define (count-list l)
  (cond
    [(empty? l) 0]
    [else (+ 1 (count-list (rest l)))]))

; List-of-list-of-strings -> Numbers
; counts the number of words in a List-of-list-of-strings
(check-expect (count-words '()) 0)
(check-expect (count-words (list (list "test"))) 1)
(check-expect (count-words (list (list "Hello,") (list "World!"))) 2)
(check-expect (count-words (list (list "Hello,") '() (list "World!"))) 2)
(define (count-words lls)
  (cond
    [(empty? lls) 0]
    [else (+ (count-list (first lls)) (count-words (rest lls)))]))

; List-of-list-of-strings -> Numbers
; counts the number of letters in a List-of-list-of-strings
(check-expect (count-letters* '()) 0)
(check-expect (count-letters* (list (list "test"))) 4)
(check-expect (count-letters* (list (list "Hello,") (list "World!"))) 12)
(check-expect (count-letters* (list (list "Hello,") '() (list "World!"))) 12)
(define (count-letters* lls)
  (cond
    [(empty? lls) 0]
    [else (+ (count-letters (first lls)) (count-letters* (rest lls)))]))

; List-of-strings -> Numbers
; counts the number of letters in a List-of-strings
(check-expect (count-letters '()) 0)
(check-expect (count-letters (list "test")) 4)
(check-expect (count-letters (list "Hello," "World!")) 12)
(define (count-letters ls)
  (cond
    [(empty? ls) 0]
    [else (+ (count-list (explode (first ls))) (count-letters (rest ls)))]))
