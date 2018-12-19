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
