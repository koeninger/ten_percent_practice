;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex98) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct ufo [x y])
; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)

(define-struct missile [x y])
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place


(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 

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


(define (si-render-missile s)
  (place-images
   (list
      TANK
      MISSILE
      UFO )
   (list
    (make-posn  (tank-loc (fired-tank s)) (- CANVAS-HEIGHT (* TANK-HEIGHT .5)))
    (fired-missile s)
    (fired-ufo s))
   BACKGROUND)
  )


(define (si-render-aim s)
  (place-images
   (list
      TANK
      UFO 
      )
   (list (make-posn (tank-loc (aim-tank s)) (- CANVAS-HEIGHT (* TANK-HEIGHT .5)))
         (aim-ufo s))
   BACKGROUND)
  )


; SIGS -> Image
; renders the given game state on top of BACKGROUND 
; for examples see figure 32
(define (si-render s)
  (cond
    [(aim? s)
     (si-render-aim s)]
    [(fired? s)
      (si-render-missile s)]))


	

; Tank Image -> Image 
; adds t to the given image im
(define (tank-render t im)
  (place-image
    TANK
    (tank-loc t) CANVAS-HEIGHT
    im))

; UFO Image -> Image 
; adds u to the given image im
(define (ufo-render u im)
  (place-image
    UFO
    (posn-x u) (posn-y u)
    im))

; Missile Image -> Image 
; adds m to the given image im
(define (missile-render m im)
  (place-image
    MISSILE
    (posn-x m) (posn-y m)
    im))



(define si-game-over? )




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