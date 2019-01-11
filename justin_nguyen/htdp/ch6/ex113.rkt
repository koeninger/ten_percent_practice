;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex113) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

(check-expect (sigs? (make-aim (make-posn 10 10) (make-tank 10 0))) #true)
(check-expect (sigs? (make-fired (make-posn 10 10) (make-tank 10 0) (make-posn 10 5))) #true)
(check-expect (sigs? 5) #false)
(check-expect (sigs? (make-tank 10 0)) #false)
(check-expect (sigs? (make-posn 10 0)) #false)
(define (sigs? s)
  (cond
    [(or (aim? s) (fired? s)) #true]
    [else #false]))

; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point


(check-expect (coordinate? 1) #true)
(check-expect (coordinate? -1) #true)
(check-expect (coordinate? (make-posn 2 3)) #true)
(check-expect (coordinate? "1") #false)
(check-expect (coordinate? 0) #false)
(define (coordinate? c)
  (cond
    [(and (number? c) (or (positive? c) (negative? c))) #true]
    [(posn? c) #true]
    [else #false]))


; A VAnimal is either
; – a VCat
; – a VCham


(define-struct vcat [pos happy])
(define-struct vcham [pos hunger color])

(check-expect (vanimal? (make-vcat 2 10)) #true)
(check-expect (vanimal? (make-vcat 0 0)) #true)
(check-expect (vanimal? (make-vcham 5 100 "red")) #true)
(check-expect (vanimal? (make-vcham 0 0 "blue")) #true)
(check-expect (vanimal? (make-posn 5 1)) #false)
(check-expect (vanimal? 1) #false)
(define (vanimal? a)
  (cond
    [(or (vcat? a) (vcham? a)) #true]
    [else #false]))


