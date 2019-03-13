//Exercise 129
1.
(cons 'mercury'
    (cons 'venus'
        (cons 'earth'
            cons 'mars' `())))
            
2. (cons 'steak'
    (cons 'french fries'
        (cons 'beans'
            (cons 'bread'
                (cons 'water'
                    (cons 'Brie cheese'
                        (cons 'ice cream' '())))))))
                        
3. (cons 'red'
    (cons 'blue'
        (cons 'green' '())))
        
//Exercise 130
(cons "a" (cons "b" (cons "c" (cons "d" (cons "e" '())))))

(cons 2 '()) isnt a List-of-names because 2 isnt a string

//Exercise 131
; A List-of-booleans is one of: 
; – '()
; – (cons boolean List-of-names)