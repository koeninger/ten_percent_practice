;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex094) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


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

(define SKETCH1
  (place-images
   (list UFO MISSILE TANK)
   (list
     (make-posn (/ WIDTH 2) UFO-INITIAL-Y)
     (make-posn (/ WIDTH 2) (/ HEIGHT 2))
     (make-posn (/ WIDTH 2) TANK-Y))
   BACKGROUND))

(define SKETCH2
  (place-images
   (list UFO MISSILE TANK)
   (list
     (make-posn (/ WIDTH 3) UFO-INITIAL-Y)
     (make-posn (/ WIDTH 4) (/ HEIGHT 2))
     (make-posn (/ WIDTH 4) TANK-Y))
   BACKGROUND))

(define SKETCH3
  (place-images
   (list UFO TANK)
   (list
     (make-posn (/ WIDTH 3) UFO-INITIAL-Y)
     (make-posn (/ WIDTH 4) TANK-Y))
   BACKGROUND))

(define SKETCH4
  (place-images
   (list UFO MISSILE TANK)
   (list
     (make-posn (/ WIDTH 2) (/ HEIGHT 2))
     (make-posn (/ WIDTH 4) 10)
     (make-posn 20 TANK-Y))
   BACKGROUND))

(define INITIAL-SCENE
  (place-images
   (list UFO TANK)
   (list
     (make-posn (/ WIDTH 2) UFO-INITIAL-Y)
     (make-posn (/ WIDTH 2) TANK-Y))
   BACKGROUND))
