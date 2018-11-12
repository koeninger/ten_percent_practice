;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex095) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

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


(define WIDTH 200)
(define HEIGHT 200)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define TANK (rectangle 30 15 "solid" "blue"))
(define MISSILE (triangle 10 "solid" "red"))
(define UFO (circle 15 "solid" "green"))
(define UFO-SPEED 3)
(define MISSILE-SPEED (* UFO-SPEED 2.5))
(define TANK-Y (- HEIGHT (/ (image-height TANK) 2)))
(define UFO-INITIAL-Y (/ (image-height UFO) 2))


(STATE1 (make-aim (make-posn 20 10)
          (make-tank 28 -3)))

(STATE2 (make-fired (make-posn 20 10)
            (make-tank 28 -3)
            (make-posn 28 (- HEIGHT (image-height TANK)))))

(STATE3 (make-fired (make-posn 20 100)
            (make-tank 100 3)
            (make-posn 22 103)))
