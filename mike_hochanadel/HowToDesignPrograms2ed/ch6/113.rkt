;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |113|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Design predicates for the following data definitions from the preceding section:
;  SIGS, Coordinate (exercise 105), and VAnimal.

; NOTE: The correct way to do this is to also define the predicates for the structs as well.
; Either I missed that step previously in earlier exercises or it wasn't asked for.
; I am only doing what the exercise asked for by doing the data definitions only.

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

; Any -> Boolen
; is an element of the Sigs collection
(check-expect (SIGS? "bob") #false)
(check-expect (SIGS? (make-aim (make-posn 1 2) (make-tank 1 2))) #true)
(check-expect (SIGS? (make-fired (make-posn 1 2) (make-tank 1 2) (make-posn 1 2))) #true)
(define (SIGS? s)
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

; Any -> Boolean
;  is the given element a Coordinate
(check-expect (coordinate? -3) #true)
(check-expect (coordinate? 0) #true)
(check-expect (coordinate? 4) #true)
(check-expect (coordinate? (make-posn 1 2)) #true)
(check-expect (coordinate? "bob") #false)
(check-expect (coordinate? #true) #false)
(define (coordinate? c)
  (cond
    [(number? c) #true]
    [(posn? c) #true]
    [else #false]))
         
(define-struct VCat [x-coordinate happiness])
; A VCat is a structure:
;    (make-vcat Number Number)
; interpretation (make-vcat (x-coordinate happiness))
; describes a virtual cat whose position on a canvas
; is (x-coordinate) and the happiness level is at
; (happiness)

(define-struct VCham [x-coordinate color happiness])
; A VCham is a structure:
;    (make-VCham Number Number Direction Number)
; interpretation (make-VCham (x-coordinate direction happiness))
; describes a virtual chameleon whose position on a canvas
; is (x-coordinate) and (y-coordinate) going in a (direction).
; The happiness level is at (happiness)

; A VAnimal is either
; – a VCat
; – a VCham

; Any -> Boolean
;  is the given element a VAnimal
(check-expect (vanimal? (make-VCat 1 2)) #true)
(check-expect (vanimal? (make-VCham 1 "blue" 3)) #true)
(check-expect (vanimal? 1) #false)
(check-expect (vanimal? #true) #false)
(check-expect (vanimal? "bob") #false)
(define (vanimal? v)
  (cond
    [(or (VCham? v) (VCat? v)) #true]
    [else #false]))