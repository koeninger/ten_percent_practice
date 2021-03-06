;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |97|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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

(define BACKGROUND_WIDTH 200)
(define BACKGROUND_HEIGHT 200)
(define BACKGROUND (empty-scene BACKGROUND_WIDTH BACKGROUND_HEIGHT))

(define MISSILE_SIZE 10)
(define MISSILE (triangle MISSILE_SIZE "solid" "red"))

(define UFO_WIDTH 30)
(define UFO_HEIGHT 10)
(define UFO (overlay
             (circle UFO_HEIGHT "solid" "green")
             (rectangle UFO_WIDTH UFO_HEIGHT "solid" "green")))

(define TANK_HEIGHT 20)
(define TANK_WIDTH 30)
(define TANK_TOP_WIDTH 10)
(define TANK (overlay/align
              "center"
              "bottom"
              (rectangle TANK_TOP_WIDTH TANK_HEIGHT "solid" "black")
              (rectangle TANK_WIDTH (/ TANK_HEIGHT  2) "solid" "black")))


; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

; tank, Image -> Image
; renders the tank on top of the given Image
(check-expect (tank-render (make-tank 60 3) BACKGROUND) (place-image
   TANK
   (tank-loc (make-tank 60 3))
   (- (image-height BACKGROUND) (/ TANK_HEIGHT 2))
   BACKGROUND))
(check-expect (tank-render (make-tank 0 56) BACKGROUND) (place-image
   TANK
   (tank-loc (make-tank 0 56))
   (- (image-height BACKGROUND) (/ TANK_HEIGHT 2))
   BACKGROUND))
(check-expect (tank-render (make-tank BACKGROUND_WIDTH 0) BACKGROUND) (place-image
   TANK
   (tank-loc (make-tank BACKGROUND_WIDTH 0))
   (- (image-height BACKGROUND) (/ TANK_HEIGHT 2))
   BACKGROUND))
(define (tank-render t im)
  (place-image
   TANK
   (tank-loc t)
   (- (image-height im) (/ TANK_HEIGHT 2))
   im))

; UFO, Image -> Image
; renders UFO on top of the given Image
(check-expect (ufo-render (make-posn 100 35) BACKGROUND) (place-image
   UFO
   (posn-x (make-posn 100 35))
   (- (image-height BACKGROUND) (posn-y (make-posn 100 35)))
   BACKGROUND))
(check-expect (ufo-render (make-posn 0 0) BACKGROUND) (place-image
   UFO
   (posn-x (make-posn 0 0))
   (- (image-height BACKGROUND) (posn-y (make-posn 0 0)))
   BACKGROUND))
(check-expect (ufo-render (make-posn BACKGROUND_WIDTH BACKGROUND_HEIGHT) BACKGROUND) (place-image
   UFO
   (posn-x (make-posn BACKGROUND_WIDTH BACKGROUND_HEIGHT))
   (- (image-height BACKGROUND) (posn-y (make-posn  BACKGROUND_WIDTH BACKGROUND_HEIGHT)))
   BACKGROUND))
(define (ufo-render u im)
  (place-image
   UFO
   (posn-x u)
   (- (image-height im) (posn-y u))
   im))

; Missile, Image -> Image
; renders Missile on top of the given Image
(check-expect (missile-render (make-posn 67 34) BACKGROUND) (place-image
   MISSILE
   (posn-x (make-posn 67 34))
   (- (image-height BACKGROUND) (posn-y (make-posn 67 34)))
   BACKGROUND))
(check-expect (missile-render (make-posn 0 0) BACKGROUND) (place-image
   MISSILE
   (posn-x (make-posn 0 0))
   (- (image-height BACKGROUND) (posn-y (make-posn 0 0)))
   BACKGROUND))
(check-expect (missile-render (make-posn BACKGROUND_WIDTH BACKGROUND_HEIGHT) BACKGROUND) (place-image
   MISSILE
   (posn-x (make-posn BACKGROUND_WIDTH BACKGROUND_HEIGHT))
   (- (image-height BACKGROUND) (posn-y (make-posn BACKGROUND_WIDTH BACKGROUND_HEIGHT)))
   BACKGROUND))
(define (missile-render m im)
  (place-image
   MISSILE
   (posn-x m)
   (- (image-height im) (posn-y m))
   im))

; SIGS -> Image
; renders the given game state on top of BACKGROUND 
; for examples see figure 32
(check-expect (si-render (make-aim (make-posn 34 40) (make-tank 150 3)))
              (tank-render (aim-tank (make-aim (make-posn 34 40) (make-tank 150 3)))
                  (ufo-render (aim-ufo (make-aim (make-posn 34 40) (make-tank 150 3))) BACKGROUND)))
(check-expect (si-render (make-fired (make-posn 180 140) (make-tank 100 34) (make-posn 180 100)))
              (tank-render
       (fired-tank (make-fired (make-posn 180 140) (make-tank 100 34) (make-posn 180 100)))
       (ufo-render (fired-ufo (make-fired (make-posn 180 140) (make-tank 100 34) (make-posn 180 100)))
                   (missile-render (fired-missile (make-fired (make-posn 180 140) (make-tank 100 34) (make-posn 180 100)))
                                   BACKGROUND))))
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