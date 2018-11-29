;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Exercise 103|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A ZooAnimal is one of
; - Spider
; - Elephant
; - Boa
; - Armadillos

; A Spider is a structure
; (make-spider Number Number Number Number)
; interpretation (make-spider #legs width height depth)
(define-struct spider [legs width height depth])

; An Elephant is a structure
; (make-elephant Number Number Number)
; interpretation (make-elephant width height depth)
(define-struct elephant [width height depth])

; A boa is a structure
; (make-boa Number Number)
; interpretation (make-boa length girth)
(define-struct boa [length girth])

; An armadillos is a structure
; (make-armadillos Number Number Number)
; interpretation (make-armedillos width height depth)
(define-struct armadillos [width height depth])

; A cage is a structure
; (make-cage Number Number Number)
; interpretation (make-cage width length depth)
(define-struct cage [width height depth])

; ZooAnimal Cage -> Boolean
; Returns true if the cage dimensions are lager than the zoo animal's dimensions
(define (fits? animal cage)
  (cond
    [(spider? animal) (smaller? (spider-width animal) (spider-height animal) (spider-depth animal) cage)]
    [(elephant? animal) (smaller? (elephant-width animal) (elephant-height animal) (elephant-depth animal) cage)]
    [(boa? animal) (smaller? (boa-length animal) (boa-girth animal) (boa-girth animal) cage)]
    [(armadillos? animal) (smaller? (armadillos-width animal) (armadillos-height animal) (armadillos-depth animal) cage)]))

; Number Number Number Cage -> Boolean
; Compares the cage dimensions with the w, h, and d dimensions
(define (smaller? w h d cage)
  (and (< w (cage-width cage))
       (< h (cage-height cage))
       (< d (cage-depth cage))))

; A vehicle is one of
; - automobile
; - van
; - bus
; - suv
; interpreation
;  seats are the number of spots for people
;  plate is the license plate number
;  mpg is the vehicle's miles per gallon
(define-struct vehicle [seats plate mpg])

(define (efficiency vehicle)
  (... (vehicle-seats vehicle) ... (vehicle-plate vehicle) ... (vehicle-mpg vehicle) ...))

; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point
-9
-23
467
894
(make-posn 9 467)
(make-posn 23 894)