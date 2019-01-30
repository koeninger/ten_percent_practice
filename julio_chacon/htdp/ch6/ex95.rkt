;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex95) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game


(define-struct aim [ufo tank])
;     (make-aim (make-posn 20 10) (make-tank 28 -3))

(define-struct fired [ufo tank missile])
;(make-fired (make-posn 20 10)
 ;(make-tank 28 -3)
  ;(make-posn 28 (- CANVAS-HEIGHT TANK-HEIGHT)))



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


; SIGS -> Image
; renders the given game state on top of BACKGROUND 
; for examples see figure 32
(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s)
     (tank-render
       (fired-tank s)
       (ufo-render (fired-ufo s)
                   (missile-render (fired-missile s)
                                   BACKGROUND)))]))


(make-aim
  (make-posn 10 20)
  (make-tank 28 -3))
	
(make-fired
  (make-posn 20 100)
  (make-tank 100 3)
  (make-posn 22 103))
	


(make-fired
  (make-posn 10 20)
  (make-tank 28 -3)
  (make-posn 32 (- CANVAS-HEIGHT TANK-HEIGHT 10)))
	

; Tank Image -> Image 
; adds t to the given image im
(define (tank-render t im) im)

; UFO Image -> Image 
; adds u to the given image im
(define (ufo-render u im) im)

; Missile Image -> Image 
; adds m to the given image im
(define (missile-render m im) im)


