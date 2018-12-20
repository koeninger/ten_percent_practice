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
