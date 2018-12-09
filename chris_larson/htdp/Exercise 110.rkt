;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 110|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Number -> Number
; computes the area of a disk with radius r
(define (area-of-disk r)
  (* 3.14 (* r r)))

; Any -> Number
; computes the area of a disk with radius v, 
; if v is a number
(define (checked-area-of-disk v)
  (cond
    [(and (number? v) (positive? v)) (area-of-disk v)]
    [else (error "area-of-disk: positive number expected")]))

(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

; Any Any -> vec
; makes a vector from x and y
; if x and y are numbers
(define (checked-make-vec x y)
  (cond
    [(and (number? x) (number? y)) (make-vec x y)]
    [else (error "checked-make-vec: number expected")]))

(define (missile-or-not? v)
  (or (false? v) (posn? v)))

(check-expect (missile-or-not? #false) #true)
(check-expect (missile-or-not? (make-posn 9 2)) #true)
(check-expect (missile-or-not? "yellow") #false)
(check-expect (missile-or-not? #true) #false)
(check-expect (missile-or-not? 10) #false)
(check-expect (missile-or-not? empty-image) #false)

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place


; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

(define (sigs-or-not? s)
  (cond
    [(aim? s) (and (posn? (aim-ufo s)) (tank? (aim-tank s)))]
    [(fired? s) (and (posn? (fired-ufo s)) (tank? (fired-tank s)) (posn? (fired-missile s)))]
    [else #false]))
(check-expect (sigs-or-not? (make-aim (make-posn 1 1) (make-tank 1 1))) #true)
(check-expect (sigs-or-not? (make-aim (make-posn 1 1) "tank")) #false)
(check-expect (sigs-or-not? (make-fired (make-posn 1 1) (make-tank 1 1) (make-posn 1 1))) #true)
(check-expect (sigs-or-not? (make-fired (make-posn 1 1) (make-tank 1 1) "missile")) #false)

; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

(define (coordinate-or-not? c)
  (cond
    [(number? c) #true]
    [(posn? c) #true]
    [else #false]))
(check-expect (coordinate-or-not? (make-posn 1 1)) #true)
(check-expect (coordinate-or-not? 1) #true)
(check-expect (coordinate-or-not? -1) #true)
(check-expect (coordinate-or-not? "coordinate") #false)

; A VAnimal is either
; – a VCat
; – a VCham

(define-struct VCat [x happy d])
(define-struct VCham [x happy d c])
(define (vanimal-or-not? a)
  (cond
    [(VCat? a) #true]
    [(VCham? a) #true]
    [else #false]))
(check-expect (vanimal-or-not? "cham") #false)
(check-expect (vanimal-or-not? (make-VCat 1 1 #true)) #true)
(check-expect (vanimal-or-not? (make-VCham 1 1 #true "blue")) #true)
(check-expect (vanimal-or-not? "cham") #false)