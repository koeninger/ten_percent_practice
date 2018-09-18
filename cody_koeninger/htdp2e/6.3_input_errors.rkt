;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 6.3_input_errors) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; Number -> Number
; computes the area of a disk with radius r
(define (area-of-disk r)
  (* 3.14 (* r r)))

; Any -> Number
; computes the area of a disk with radius v, 
; if v is a number
(define (checked-area-of-disk v)
  (cond
    [(and (number? v) (< 0 v)) (area-of-disk v)]
    [else (error "area-of-disk: positive number expected")]))


(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

(define (checked-make-vec x y)
  (cond
    [(and (number? x) (number? y) (< 0 x) (< 0 y))
     (make-vec x y)]
    [else (error "make-vec: expected positive numbers for x and y")]))

; a MissileOrNot is either #false, indicating it hasn't been fired, or a posn

; Any -> Boolean
; is a an element of MissleOrNot
(check-expect (missile-or-not? #false) #true)
(check-expect (missile-or-not? (make-posn 9 2)) #true)
(check-expect (missile-or-not? "yellow") #false)
(check-expect (missile-or-not? #true) #false)
(check-expect (missile-or-not? 10) #false)
(check-expect (missile-or-not? empty-image) #false)
(define (missile-or-not? m)
  (cond
    [(boolean? m) (not m)]
    [(posn? m) #true]
    [else #false]))

(check-expect (missile-or-not2? #false) #true)
(check-expect (missile-or-not2? (make-posn 9 2)) #true)
(check-expect (missile-or-not2? "yellow") #false)
(check-expect (missile-or-not2? #true) #false)
(check-expect (missile-or-not2? 10) #false)
(check-expect (missile-or-not2? empty-image) #false)
(define (missile-or-not2? m)
  (or (false? m) (posn? m)))

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
(define (sigs? s)
  (or (aim? s) (fired? s)))

; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

(define (coordinate? c)
  (or (number? c) (posn? c)))

; A VAnimal is either
; – a VCat
; – a VCham

(define-struct vcat [x-coord happiness velocity])
(define-struct vcham [x-coord happiness color])

(define (vanimal? v)
  (or (vcat? v) (vcham? v)))


; Any -> Boolean
; is the given value an element of TrafficLight
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

(define MESSAGE
  "traffic light expected, given some other value")
 
; Any Any -> Boolean
; are the two values elements of TrafficLight and, 
; if so, are they equal
 
(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)
 
(define (light=? a-value another-value)
  (cond
    [(and (not (light? a-value)) (not (light? another-value)))
     (error "neither a-value nor another-value are lights")]
    [(not (light? a-value))
     (error "a-value is not a light")]
    [(not (light? another-value))
     (error "another-value is not a light")]
    [else
     (string=? a-value another-value)]))