;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex113) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

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

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
; A SIGS is one of:
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a
; space invader game

; Any -> Boolean
; is a an element of the SIGS collection
(check-expect (SIGS? (make-aim (make-posn 0 0) (make-tank 0 0))) #true)
(check-expect (SIGS? (make-fired (make-posn 0 0) (make-tank 0 0) (make-posn 0 0))) #true)
(check-expect (SIGS? "yellow") #false)
(check-expect (SIGS? (make-fired (make-posn 0 0) (make-tank 0 0) (make-posn 0 0))) #true)
(define (SIGS? v)
  (or (aim? v) (fired? v)))


; A Coordinate is one of:
; – a NegativeNumber
; interpretation on the y axis, distance from top
; – a PositiveNumber
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

; Any -> Boolean
; is a an element of the Coordinate collection
(check-expect (Coordinate? -1) #true)
(check-expect (Coordinate? 0) #true)
(check-expect (Coordinate? 1) #true)
(check-expect (Coordinate? (make-posn 0 0)) #true)
(check-expect (Coordinate? "test") #false)
(define (Coordinate? v)
  (or (number? v) (posn? v)))


(define-struct VCat [x-coor happy])
; A VCat is a structure:
;   (make-VCat Number Number)
; interpretation (make-VCat x h) describes a cat
; where x is the number of pixels between the left border of the
; scene and h is its happiness level (0-100) represented as the
; width in pixels of the happiness-gauge and is either "left"
; or "right" representing the direction the cat will move in

(define-struct VCham [x-coor happy color])
; A VCham is a structure:
;   (make-VCham Number Number String)
; interpretation (make-VCham x h c) describes a
; chameleon where x is the number of pixels between the left
; border of the scene; h is its happiness level (0-100)
; represented as the width in pixels of the happiness-gauge
; and c is the color "r" turns it red, "b" blue, and "g" green

; A VAnimal is either
; – a VCat
; – a VCham

; Any -> Boolean
; is a an element of the VAnimal collection
(check-expect (VAnimal? (make-VCat 25 100)) #true)
(check-expect (VAnimal? (make-VCham 72 100 "g")) #true)
(check-expect (VAnimal? "test") #false)
(define (VAnimal? v)
  (or (VCat? v) (VCham? v)))
