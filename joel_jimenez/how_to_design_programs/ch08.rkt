;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ch08) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 129. Create BSL lists that represent

; 1. a list of celestial bodies, say, at least all the planets in our solar system
(cons "Neptune"
  (cons "Uranus"
    (cons "Saturn"
      (cons "Jupiter"
        (cons "Mars"
          (cons "Earth"
            (cons "Venus"
              (cons "Mercury"
                (cons "Sun" '())))))))))

; 2. a list of items for a meal, for example, steak, french fries, beans, bread,
;    water, Brie cheese, and ice cream
(cons "Tortilla"
  (cons "Chicken"
    (cons "Beans"
      (cons "Rice"
        (cons "Cheese"
          (cons "Salsa"
            (cons "Guacamole" '())))))))

; 3. and a list of colors.
(cons "Red"
  (cons "Orange"
    (cons "Yellow"
      (cons "Green"
        (cons "Blue"
          (cons "Purple" '()))))))


; Exercise 130. Create an element of List-of-names that contains five Strings.
(cons "Lennon"
  (cons "McCartney"
    (cons "Harrison"
      (cons "Starr"
        (cons "Jimenez" '())))))
;   Explain why (cons "1" (cons "2" '())) is an element of List-of-names and why (cons 2 '()) isn’t.
;   The values in the list (cons "1" (cons "2" '())) are strings, "1" and "2".
;   The value in (cons 2 '()) is a number, 2.


; Exercise 131. Provide a data definition for representing lists of Boolean values.
;   The class contains all arbitrarily long lists of Booleans.

; A List-of-bools is one of:
; – '()
; – (cons Boolean List-of-bools)
; interpretation a list of answers to true/false questions in a test


; 8.2
(define-struct pair [left right])
; A ConsPair is a structure:
;   (make-pair Any Any).

; ConsOrEmpty -> Any
; extracts the right part for the given pair
(check-expect (our-rest (make-pair 1 2)) 2)
(define (our-rest a-list)
  (if (empty? a-list)
      (error 'our-rest "...")
      (pair-right a-list)))


; 8.3

; List-of-names -> Boolean
; determines whether "Flatt" is on a-list-of-names
(check-expect (contains-flatt? '()) #false)
(check-expect (contains-flatt? (cons "Find" '()))
              #false)
(check-expect (contains-flatt? (cons "Flatt" '()))
              #true)
(check-expect
  (contains-flatt?
    (cons "A" (cons "Flatt" (cons "C" '()))))
  #true)
(check-expect
  (contains-flatt?
    (cons "A" (cons "B" (cons "C" '()))))
  #false)
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon) 
     (or (string=? (first alon) "Flatt")
         (contains-flatt? (rest alon)))]))


; Exercise 132. Use DrRacket to run contains-flatt? in this example:
(define ex132 (cons "Fagan"
  (cons "Findler"
    (cons "Fisler"
      (cons "Flanagan"
        (cons "Flatt"
          (cons "Felleisen"
            (cons "Friedman" '()))))))))
; What answer do you expect?
(check-expect (contains-flatt? ex132) #true)


; Exercise 133. Here is another way of formulating the second cond clause in contains-flatt?:
; ... (cond
;       [(string=? (first alon) "Flatt") #true]
;       [else (contains-flatt? (rest alon))]) ...
; Explain why this expression produces the same answers as the or expression
; in the version of figure 47. Which version is better? Explain.

; It returns #true, with [(string=? (first alon) "Flatt") #true], as soon as "Flatt" matches.
; This is better since it makes it eisier to see where #true is returned


; Exercise 134. Develop the contains? function, which determines
; whether some given string occurs on a given list of strings.

; String, List-of-names -> Boolean
; determines whether the given string is on a-list-of-names
(check-expect (contains? "Find" '())
              #false)
(check-expect (contains? "Find" (cons "Find" '()))
              #true)
(check-expect (contains? "Find" (cons "A" (cons "Find" (cons "C" '()))))
              #true)
(check-expect (contains? "Find" (cons "A" (cons "B" (cons "C" '()))))
              #false)
(define (contains? s alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon) 
     (or (string=? (first alon) s)
         (contains? s (rest alon)))]))
