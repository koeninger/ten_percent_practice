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
