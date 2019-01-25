;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex94) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


(define CANVAS-WIDTH 400)
(define CANVAS-HEIGHT 400)
(define BACKGROUND (empty-scene CANVAS-WIDTH CANVAS-HEIGHT))


(define TANK-HEIGHT 20)
(define TANK (rectangle 40 TANK-HEIGHT "solid" "green"))
(define TANK-SPEED 2)

(define MISSILE (triangle (* TANK-HEIGHT .5) "solid" "black"))

(define UFO (ellipse 40 20 "solid" "red"))
(define UFO-SPEED 2)


(define render
  (place-images
   (list
      TANK
      MISSILE
      UFO 
      )
   (list (make-posn 200 (- CANVAS-HEIGHT (* TANK-HEIGHT .5)))
         (make-posn 200 100)
         (make-posn 200 10))
   BACKGROUND)

  )

render
