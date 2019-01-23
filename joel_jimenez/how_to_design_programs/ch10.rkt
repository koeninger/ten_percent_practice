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
