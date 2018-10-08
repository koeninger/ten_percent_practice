;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9_self_referential) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/universe)

; 137
; both contains-flatt and how-many have the empty list as the base case, and recur on the rest of the list as the other case

; 138

; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)

; sum of a list of amounts
; list-of-amounts -> positive number
(check-expect (sum '()) 0)
(check-expect (sum (cons 1 '())) 1)
(check-expect (sum (cons 2 (cons 1 '()))) 3)
(define (sum aloa)
  (cond
    [(empty? aloa) 0]
    [(cons? aloa)
     (+ (first aloa) (sum (rest aloa)))]))


; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)

; are all of alon positive
; list-of-numbers -> boolean
(check-expect (pos? '()) #t)
(check-expect (pos? (cons 1 '())) #t)
(check-expect (pos? (cons 1 (cons -2 '()))) #f)
(define (pos? alon)
  (cond
    [(empty? alon) #t]
    [(cons? alon)
     (and (positive? (first alon)) (pos? (rest alon)))]))



; sum of a list of numbers, only if all positive
; list-of-numbers -> positive number
(check-expect (checked-sum '()) 0)
(check-expect (checked-sum (cons 1 '())) 1)
(check-expect (checked-sum (cons 2 (cons 1 '()))) 3)
(check-error (checked-sum (cons 2 (cons -1 '()))) "checked-sum: expected list of positive numbers")
(define (checked-sum ns)
  (cond
    [(empty? ns) 0]
    [(cons? ns)
     (cond
       [(positive? (first ns))
        (+ (first ns) (checked-sum (rest ns)))]
       [else (error 'checked-sum "expected list of positive numbers")])]))

; are all of the list of booleans true
; list-of-booleans -> boolean
(check-expect (all-true '()) #t)
(check-expect (all-true (cons #t '())) #t)
(check-expect (all-true (cons #t (cons #f '()))) #f)
(define (all-true bs)
  (cond
    [(empty? bs) #t]
    [(cons? bs)
     (and (first bs) (all-true (rest bs)))]))

; is one of the list of booleans true
; list-of-booleans -> boolean
(check-expect (one-true '()) #f)
(check-expect (one-true (cons #t '())) #t)
(check-expect (one-true (cons #t (cons #f '()))) #t)
(check-expect (one-true (cons #f (cons #f '()))) #f)
(define (one-true bs)
  (cond
    [(empty? bs) #f]
    [(cons? bs)
     (or (first bs) (one-true (rest bs)))]))


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



; ImageOrFalse is one of:
; – Image
; – #false

; number -> list-of-images -> ImageOrFalse
; returns the first image that isn't an n * n square, or #false
(check-expect (ill-sized? 2 '())
              #f)
(check-expect (ill-sized? 2 (cons (rectangle 2 2 "solid" "red") '()))
              #f)
(check-expect (ill-sized? 3 (cons (rectangle 2 2 "solid" "red") '()))
              (rectangle 2 2 "solid" "red"))
(check-expect (ill-sized? 2 (cons (rectangle 2 2 "solid" "red") (cons (rectangle 2 3 "solid" "red") '())))
              (rectangle 2 3 "solid" "red"))
(define (ill-sized? n imgs)
  (cond
    [(empty? imgs) #false]
    [(cons? imgs)
     (if (= n (image-height (first imgs)) (image-width (first imgs)))
         (ill-sized? n (rest imgs))
         (first imgs))]))

(define (how-many alos)
  (cond
    [(empty? alos) 0]
    [else (+ (how-many (rest alos)) 1)]))


; List-of-temperatures -> Number
; computes the average temperature
(check-expect
  (average (cons 1 (cons 2 (cons 3 '())))) 2)
(define (average alot)
  (/ (sum alot) (how-many alot)))

(define (checked-average ts)
  (if (empty? ts)
      (error 'checked-average "expected non-empty list")
      (average ts)))

; 144
; sum and how-many will work for NELs, because NEL is a subcategory of all lists, and they work for all numeric lists


; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures 


; true if temperatures are sorted in descending order
; NEList-of-temperatures -> boolean
(check-expect (sorted>? (cons 1 '())) #t)
(check-expect (sorted>? (cons 2 (cons 1 '()))) #t)
(check-expect (sorted>? (cons 1 (cons 2 '()))) #f)
(define (sorted>? ts)
  (cond
    [(empty? (rest ts)) #t]
    [else (and (> (first ts) (second ts))
               (sorted>? (rest ts)))]))

; count of temperatures
; NEList-of-temperatures -> number
(check-expect (how-many2 (cons 1 '())) 1)
(check-expect (how-many2 (cons 2 (cons 1 '()))) 2)
(define (how-many2 ts)
  (cond
    [(empty? (rest ts)) 1]
    [else (+ 1 (how-many2 (rest ts)))]))


; are all of the NEList of booleans true
; NEList-of-booleans -> boolean
(check-expect (all-true2 (cons #t '())) #t)
(check-expect (all-true2 (cons #f '())) #f)
(check-expect (all-true2 (cons #t (cons #t '()))) #t)
(check-expect (all-true2 (cons #t (cons #f '()))) #f)
(define (all-true2 bs)
  (cond
    [(empty? (rest bs)) (first bs)]
    [else
     (and (first bs) (all-true2 (rest bs)))]))

; is one of the list of booleans true
; NEList-of-booleans -> boolean
(check-expect (one-true2 (cons #f '())) #f)
(check-expect (one-true2 (cons #t '())) #t)
(check-expect (one-true2 (cons #t (cons #f '()))) #t)
(check-expect (one-true2 (cons #f (cons #f '()))) #f)
(define (one-true2 bs)
  (cond
    [(empty? (rest bs)) (first bs)]
    [else
     (or (first bs) (one-true2 (rest bs)))]))

; 148 without enforcement of types, it's better to have definitions that can return a sensible answer for empty lists, rather than a runtime error


; N String -> List-of-strings 
; creates a list of n copies of s
 
(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello")
              (cons "hello" (cons "hello" '())))
 
(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons s (copier (sub1 n) s))]))

; 149 yes copier returns a sensible answer even if the second argument isn't a string

(define (copier.v2 n s)
  (cond
    [(zero? n) '()]
    [else (cons s (copier.v2 (sub1 n) s))]))

; copier.v2 can recurse infinitely on anything other than a non-negative integer

; N -> Number
; computes (+ n pi) without using +
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [(positive? n) (add1 (add-to-pi (sub1 n)))]))

; N Number -> Number
; computes (+ n x without using +
(check-within (add 3 pi) (+ 3 pi) 0.001)
(check-within (add 4 6.66) (+ 4 6.66) 0.001)
(define (add n x)
  (cond
    [(zero? n) x]
    [(positive? n) (add1 (add (sub1 n) x))]))

; N Number -> Number
; computes (* n x without using *
(check-within (multiply 3 pi) (* 3 pi) 0.001)
(check-within (multiply 4 6.66) (* 4 6.66) 0.001)
(define (multiply n x)
  (cond
    [(zero? n) 0]
    [(positive? n) (+ x (multiply (sub1 n) x))]))

; N img -> img
; vertical column of n copies of img
(check-expect (col 1 (rectangle 10 10 "solid" "blue")) (rectangle 10 10 "solid" "blue") )
(check-expect (col 2 (rectangle 10 10 "solid" "blue")) (above (rectangle 10 10 "solid" "blue")
                                                              (rectangle 10 10 "solid" "blue")))
(define (col n img)
  (cond
    [(zero? n) (empty-scene 0 0)]
    [(positive? n) (above img (col (sub1 n) img))]))
              
; N img -> img
; horizontal row of n copies of img
(check-expect (row 1 (rectangle 10 10 "solid" "blue")) (rectangle 10 10 "solid" "blue") )
(check-expect (row 2 (rectangle 10 10 "solid" "blue")) (beside (rectangle 10 10 "solid" "blue")
                                                              (rectangle 10 10 "solid" "blue")))
(define (row n img)
  (cond
    [(zero? n) (empty-scene 0 0)]
    [(positive? n) (beside img (row (sub1 n) img))]))

(define lecture-hall (row 8 (col 18 (rectangle 10 10 "outline" "black"))))

; list of posn -> img
; image of lecture hall with red dots at posns
(check-expect (add-balloons '()) lecture-hall)
(check-expect (add-balloons (list (make-posn 23 42))) (place-image (circle 3 "solid" "red") 23 42 lecture-hall))
(define (add-balloons posns)
  (cond
    [(empty? posns) lecture-hall]
    [else (place-image (circle 3 "solid" "red") (posn-x (first posns)) (posn-y (first posns)) (add-balloons (rest posns)))]))


(define-struct layer [color doll])

; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)

; RD -> string
; string describing all colors in russian doll
(check-expect (colors "blue") "blue")
(check-expect (colors (make-layer "blue" "green")) "blue, green")
(check-expect (colors (make-layer "red" (make-layer "blue" "green"))) "red, blue, green")
(define (colors rd)
  (cond
    [(string? rd) rd]
    [(layer? rd)
     (string-append (layer-color rd) ", " (colors (layer-doll rd)))]))

; RD -> string
; color of innermost doll
(check-expect (inner "red") "red")
(check-expect (inner (make-layer "blue" "red")) "red")
(check-expect (inner (make-layer "green" (make-layer "blue" "red"))) "red")
(define (inner rd)
  (cond
    [(string? rd) rd]
    [(layer? rd) (inner (layer-doll rd))]))

; ex 156

(define HEIGHT 220) ; distances in terms of pixels 
(define WIDTH 30)
(define XSHOTS (- (/ WIDTH 2) 5))
 
; graphical constants 
(define BACKGROUND (overlay (rectangle WIDTH HEIGHT "solid" "green") (empty-scene WIDTH HEIGHT)))
(define SHOT (rectangle 7 3 "solid" "black"))

; ShotWorld -> ShotWorld 
(define (main w0)
  (big-bang w0
    [on-tick tock]
    [on-key keyh]
    [to-draw to-image]))
 
; ShotWorld -> ShotWorld 
; moves each shot up by one pixel
(check-expect (tock '()) '())
(check-expect (tock (cons 1 '())) (cons 0 '()))
(define (tock w)
  (cond
    [(empty? w) '()]
    [(negative? (first w)) (tock (rest w))]
    [else (cons (sub1 (first w)) (tock (rest w)))]))
 
; ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world if the space bar is hit 
(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))
 
; ShotWorld -> Image 
; adds each shot y on w at (XSHOTS,y} to BACKGROUND
(check-expect (to-image '()) BACKGROUND)
(check-expect (to-image (cons 1 '())) (place-image SHOT XSHOTS 1 BACKGROUND))
(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOTS (first w)
                       (to-image (rest w)))]))

; ex 159

(define-struct pair [balloon# lob])
; A Pair is a structure (make-pair N List-of-posns)
; A List-of-posns is one of: 
; – '()
; – (cons Posn List-of-posns)
; interpretation (make-pair n lob) means n balloons 
; must yet be thrown and added to lob

; pair -> image
; draw balloons in pair
(check-expect (draw-balloons (make-pair 4 '())) (add-balloons '()))
(check-expect (draw-balloons (make-pair 3 (list (make-posn 23 42)))) (add-balloons (list (make-posn 23 42))))
(define (draw-balloons p)
  (add-balloons (pair-lob p)))

; pair -> pair
; randomly throw (add to list of posns) 1 balloon per tick
(check-random (throw-balloons (make-pair 0 '())) (make-pair 0 '()))
(check-random (throw-balloons (make-pair 1 '())) (make-pair 0 (list (random-posn (image-width lecture-hall) (image-height lecture-hall)))))
(define (throw-balloons p)
  (if (<= (pair-balloon# p) 0)
      p
      (make-pair (sub1 (pair-balloon# p)) (cons (random-posn (image-width lecture-hall) (image-height lecture-hall)) (pair-lob p)))))

; n n -> posn
; random posn between 0,0 and xmax,ymax
(define (random-posn xmax ymax)
  (make-posn (random xmax) (random ymax)))

(define (riot n)
  (big-bang (make-pair n '())
    [on-tick throw-balloons]
    [to-draw draw-balloons]))

; List-of-string String -> N
; determines how often s occurs in los
(check-expect (count (list "a" "b" "c" "b") "z") 0)
(check-expect (count (list "a" "b" "c" "b") "b") 2)
(define (count los s)
  (cond
    [(empty? los) 0]
    [(cons? los)
     (if (eq? (first los) s)
         (add1 (count (rest los) s))
         (count (rest los) s))]))


; A Son.L is one of: 
; – empty 
; – (cons Number Son.L)
; 
; Son is used when it 
; applies to Son.L and Son.R
  

; A Son.R is one of: 
; – empty 
; – (cons Number Son.R)
; 
; Constraint If s is a Son.R, 
; no number occurs twice in s

; Son
(define es '())
 
; Number Son -> Boolean
; is x in s
(define (in? x s)
  (member? x s))

; Number Son.L -> Son.L
; removes x from s 
(define s1.L
  (cons 1 (cons 1 '())))
 
(check-expect
  (set-.L 1 s1.L) es)
(define (set-.L x s)
  (remove-all x s))
  

; Number Son.R -> Son.R
; removes x from s
(define s1.R
  (cons 1 '()))
 
(check-expect
  (set-.R 1 s1.R) es)
(define (set-.R x s)
  (remove x s))

; Number Son.L -> Son.L
; adds x to s
(check-expect (set+.L 1 es) (cons 1 es))
(check-expect (set+.L 1 s1.L) (cons 1 s1.L))
(define (set+.L x s)
  (cons x s))

; Number Son.R -> Son.R
; adds x to s
(check-expect (set+.R 1 es) (cons 1 es))
(check-expect (set+.R 1 s1.R) s1.R)
(define (set+.R x s)
  (if (in? x s)
      s
      (cons x s)))