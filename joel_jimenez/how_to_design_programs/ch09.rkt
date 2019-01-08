;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ch09) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-strings is one of:
; – '()
; – (cons String List-of-strings)

; List-of-strings -> Number
; counts how many strings alos contains
(check-expect (how-many '()) 0)
(check-expect (how-many (cons "a" '())) 1)
(check-expect (how-many (cons "b" (cons "a" '()))) 2)
(define (how-many alos)
  (cond
    [(empty? alos) 0]
    [else (+ (how-many (rest alos)) 1)]))


; Exercise 137. Compare the template for contains-flatt? with the one for how-many.
;               Ignoring the function name, they are the same. Explain the similarity.
; They both call themselves untill the condition empty? is #true


; Exercise 138. Here is a data definition for representing sequences of amounts of money:

; A List-of-amounts is one of:
; – '()
; – (cons PositiveNumber List-of-amounts)

; Create some examples to make sure you understand the data definition.
; Also add an arrow for the self-reference.
; Design the sum function, which consumes a List-of-amounts and computes the sum of the amounts.
; Use DrRacket’s stepper to see how (sum l) works for a short list l in List-of-amounts.

'() ; by the first clause
(cons 1 '()) ; by the second clause, previous example
(cons 2 (cons 1 '())); by the second clause, previous example

; List-of-amounts -> Number
; computes the sum of the amounts aloa contains
(check-expect (sum '()) 0)
(check-expect (sum (cons 1 '())) 1)
(check-expect (sum (cons 2 (cons 1 '()))) 3)
(define (sum aloa)
  (cond
    [(empty? aloa) 0]
    [else (+ (first aloa) (sum (rest aloa)))]))


; Exercise 139.

; A List-of-numbers is one of:
; – '()
; – (cons Number List-of-numbers)

; List-of-numbers -> Boolean
; determines whether all numbers in alon are positive numbers
(check-expect (pos? '()) #true)
(check-expect (pos? (cons 5 '())) #true)
(check-expect (pos? (cons -1 '())) #false)
(define (pos? alon)
  (cond
    [(empty? alon) #true]
    [(< (first alon) 0) #false]
    [else (pos? (rest alon))]))

; List-of-numbers -> Boolean
; produces the sum all numbers in alon if they belong to List-of-amounts; otherwise it signals an error
(check-expect (checked-sum '()) 0)
(check-expect (checked-sum (cons 5 '())) 5)
(check-error (checked-sum (cons -1 '())) "checked-sum: input does not belong to List-of-amounts")
(define (checked-sum alon)
  (cond
    [(pos? alon) (sum alon)]
    [else (error "checked-sum: input does not belong to List-of-amounts")]))


; Exercise 140.

; A List-of-bools is one of:
; – '()
; – (cons Boolean List-of-bools)

; List-of-bools -> Boolean
; determines whether all values in alob is #true
(check-expect (all-true '()) #true)
(check-expect (all-true (cons #true '())) #true)
(check-expect (all-true (cons #false '())) #false)
(check-expect (all-true (cons #false (cons #true '()))) #false)
(check-expect (all-true (cons #false (cons #false '()))) #false)
(check-expect (all-true (cons #true (cons #true '()))) #true)
(define (all-true alob)
  (cond
    [(empty? alob) #true]
    [(false? (first alob)) #false]
    [else (all-true (rest alob))]))

; List-of-bools -> Boolean
; determines whether at least one value in alob is #true
(check-expect (one-true '()) #false)
(check-expect (one-true (cons #true '())) #true)
(check-expect (one-true (cons #false '())) #false)
(check-expect (one-true (cons #true (cons #false '()))) #true)
(check-expect (one-true (cons #false (cons #false '()))) #false)
(define (one-true alob)
  (cond
    [(empty? alob) #false]
    [(not (false? (first alob))) #true]
    [else (one-true (rest alob))]))

; Exercise 141.
; | l                   | (first l) | (rest l)     | (cat (rest l)) | (cat l)  |
; |---------------------|-----------|--------------|----------------|----------|
; |(cons "a"            | "a"       | (cons "b"    | "b"            | "ab"     |
; |  (cons "b"          |           |   '())       |                |          |
; |    '()))            |           |              |                |          |
; |(cons "ab"           | "ab"      | (cons "cd"   | "cdef"         | "abcdef" |
; |  (cons "cd"         |           |   (cons "ef" |                |          |
; |    (cons "ef" '())) |           |     '())     |                |          |

; List-of-string -> String
; concatenates all strings in l into one long string
(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect
  (cat (cons "ab" (cons "cd" (cons "ef" '()))))
  "abcdef")
(define (cat l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l) (cat (rest l)))]))

(cat (cons "a" '()))
; (cond
;   [(empty? (cons "a" '())) ""]
;   [else (string-append (first (cons "a" '())) (cat (rest (cons "a" '()))))])
; (cond
;   [#false ""]
;   [else (string-append (first (cons "a" '())) (cat (rest (cons "a" '()))))])
; (string-append "a" (cat '()))
; (string-append "a"
;   (cond
;     [(empty?  '()) ""]
;     [else (string-append (first '()) (cat (rest '())))]))
; (string-append "a"
;   (cond
;     [#true ""]
;     [else (string-append (first '()) (cat (rest '())))]))
; (string-append "a" "")
; "a"


; Exercise 142.
(require 2htdp/image)

; A List-of-images is one of:
; – '()
; – (cons Image List-of-images)

; ImageOrFalse is one of:
; – Image
; – #false

(define rec1
  (rectangle 5 10 "solid" "black"))
(define square1
  (rectangle 5 5 "solid" "black"))
(define rec2
  (rectangle 15 10 "solid" "black"))

; List-of-images -> ImageOrFalse
; concatenates all strings in l into one long string
(check-expect (ill-sized? '() 5) #false)
(check-expect (ill-sized? (cons rec1 '()) 5) #false)
(check-expect (ill-sized? (cons square1 (cons rec1 '())) 5) square1)
(define (ill-sized? aloi n)
  (cond
    [(empty? aloi) #false]
    [(and (= (image-width (first aloi)) n)
          (= (image-height (first aloi)) n))
       (first aloi)]
    [else (ill-sized? (rest aloi) n)]))


; 9.2 Non-empty Lists

; A List-of-temperatures is one of:
; – '()
; – (cons CTemperature List-of-temperatures)

; A CTemperature is a Number greater than -273.

; List-of-temperatures -> Number
; computes the average temperature
(check-expect
  (average (cons 1 (cons 2 (cons 3 '())))) 2)
(define (average alot)
  (/ (sum alot) (how-many alot)))


; Exercise 143. Determine how average behaves in DrRacket when applied to the
; empty list. Then design checked-average, a function that produces an
; informative error message when it is applied to '().

;   ERROR, /: division by zero

; List-of-temperatures -> Number
; computes the average temperature from List-of-temperatures, or error when empty
(check-expect
  (checked-average (cons 1 (cons 2 (cons 3 '())))) 2)
(check-error
  (checked-average '()) "List is empty.")
(define (checked-average alot)
  (cond
    [(empty? alot) (error "List is empty.")]
    [else (average alot)]))


; NEList-of-temperatures -> Number
; computes the average temperature
(check-expect
  (ne-average (cons 1 (cons 2 (cons 3 '())))) 2)
(define (ne-average ne-l)
  (/ (sum-ne ne-l)
     (how-many-ne ne-l)))


; Exercise 144. Will sum and how-many work for NEList-of-temperatures even though
; they are designed for inputs from List-of-temperatures? If you think they don’t
; work, provide counter-examples. If you think they would, explain why.

; Yes, because sum and how-many work for List-of-temperatures and NEList-of-temperatures
;   is a subset of List-of-temperatures.


; NEList-of-temperatures -> Number
; computes the sum of the given temperatures
(check-expect
  (sum-ne (cons 1 (cons 2 (cons 3 '())))) 6)
(define (sum-ne ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (+ (first ne-l) (sum-ne (rest ne-l)))]))


; Exercise 145.

; NEList-of-temperatures -> Boolean
; produces #true if the temperatures are sorted in descending order, else #false
(check-expect
  (sorted>? (cons 1 (cons 2 (cons 3 '())))) #false)
(check-expect
  (sorted>? (cons 1 (cons 3 (cons 2 '())))) #false)
(check-expect
  (sorted>? (cons 3 (cons 2 (cons 1 '())))) #true)
(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) #true]
    [(< (first ne-l) (first(rest ne-l))) #false]
    [else (sorted>? (rest ne-l))]))


; Exercise 146.

; NEList-of-temperatures -> Number
; counts how many temperatures ne-l contains
(check-expect
  (how-many-ne (cons 2 (cons 3 '()))) 2)
(check-expect
  (how-many-ne (cons 2 '())) 1)
(define (how-many-ne ne-l)
  (cond
    [(empty? (rest ne-l)) 1]
    [else (+ 1 (how-many-ne (rest ne-l)))]))


; Exercise 147.

; An NEList-of-Booleans is one of:
; – (cons Boolean '())
; – (cons Boolean NEList-of-Booleans)
; interpretation non-empty lists of Boolean values

; NEList-of-Booleans -> Boolean
; determines whether all values in ne-lob is #true
(check-expect (ne-all-true (cons #true '())) #true)
(check-expect (ne-all-true (cons #false '())) #false)
(check-expect (ne-all-true (cons #false (cons #true '()))) #false)
(check-expect (ne-all-true (cons #false (cons #false '()))) #false)
(check-expect (ne-all-true (cons #true (cons #true '()))) #true)
(define (ne-all-true ne-lob)
  (cond
    [(empty? (rest ne-lob)) (first ne-lob)]
    [(false? (first ne-lob)) #false]
    [else (ne-all-true (rest ne-lob))]))

; NEList-of-Booleans -> Boolean
; determines whether at least one value in ne-lob is #true
(check-expect (ne-one-true (cons #true '())) #true)
(check-expect (ne-one-true (cons #false '())) #false)
(check-expect (ne-one-true (cons #true (cons #false '()))) #true)
(check-expect (ne-one-true (cons #false (cons #false '()))) #false)
(define (ne-one-true ne-lob)
  (cond
    [(empty? (rest ne-lob)) (first ne-lob)]
    [(not (false? (first ne-lob))) #true]
    [else (one-true (rest ne-lob))]))


; 9.3 Natural Numbers

; An N is one of:
; – 0
; – (add1 N)
; interpretation represents the counting numbers

; N String -> List-of-strings
; creates a list of n copies of s
(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello")
              (cons "hello" (cons "hello" '())))
(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons s (copier (sub1 n) s))]))


; Exercise 149.

(define (copier.v2 n s)
  (cond
    [(zero? n) '()]
    [else (cons s (copier.v2 (sub1 n) s))]))
; (copier.v2 0.1 "x")
; (cond  [(zero? 0.1) '()] [else (cons "x" (copier.v2 (sub1 0.1) "x"))]))
; (cond  [#false '()] [else (cons "x" (copier.v2 (sub1 0.1) "x"))]))
; (cons "x" (copier.v2 (sub1 0.1) "x"))
; (cons "x" (copier.v2 -0.9 "x"))
; (cons "x" (cond  [(zero? -0.9) '()] [else (cons "x" (copier.v2 (sub1 -0.9) "x"))])))
; (cons "x" (cons "x" (copier.v2 (sub1 -0.9) "x")))))
; INFINITE LOOP


; Exercise 150.

; N -> Number
; computes (+ n pi) without using +
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [(positive? n) (add1 (add-to-pi (sub1 n)))]))


; Exercise 151;

; N, Number -> Number
; It consumes a natural number n and multiplies it with a number x without using *.
(check-expect (multiply 3 5) 15)
(check-expect (multiply 0 5) 0)
(check-expect (multiply 1 -5) -5)
(define (multiply n x)
  (cond
    [(zero? n) 0]
    [(positive? n) (+ (multiply (sub1 n) x) x)]))


; Exercise 152.

(define REC1 (rectangle 10 10 "outline" "black"))

; N, Image -> Image
; produces a column—a vertical arrangement—of n copies of img
(check-expect (col 3 REC1) (above REC1 (above REC1 (above REC1 empty-image))))
(check-expect (col 0 REC1) empty-image)
(define (col n img)
  (cond
    [(zero? n) empty-image]
    [(positive? n) (above img (col (sub1 n) img))]))

; N, Image -> Image
; produces a row—a horizontal arrangement—of n copies of img
(check-expect (row 3 REC1) (beside REC1 (beside REC1 (beside REC1 empty-image))))
(check-expect (row 0 REC1) empty-image)
(define (row n img)
  (cond
    [(zero? n) empty-image]
    [(positive? n) (beside img (row (sub1 n) img))]))
