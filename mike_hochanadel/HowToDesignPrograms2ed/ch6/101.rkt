;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |101|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 

; A MissileOrNot is one of: 
; – #false
; – Posn
; interpretation#false means the missile is in the tank;
; Posn says the missile is at that location

(define-struct sigs [ufo tank missile])
; A SIGS.v2 (short for SIGS version 2) is a structure:
;   (make-sigs UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game

(define BACKGROUND_WIDTH 200)
(define BACKGROUND_HEIGHT 200)
(define BACKGROUND (empty-scene BACKGROUND_WIDTH BACKGROUND_HEIGHT))

(define MISSILE_SIZE 10)
(define MISSILE (triangle MISSILE_SIZE "solid" "red"))
(define MISSILE_SPEED 5)

(define UFO_WIDTH 30)
(define UFO_HEIGHT 20)
(define UFO (overlay
             (circle (/ UFO_HEIGHT 2) "solid" "green")
             (rectangle UFO_WIDTH (/ UFO_HEIGHT 2) "solid" "green")))
(define UFO_MOVE_RANGE 10)
(define UFO_LANDING_SPEED 2)

(define TANK_HEIGHT 20)
(define TANK_WIDTH 30)
(define TANK_TOP_WIDTH 10)
(define TANK (overlay/align
              "center"
              "bottom"
              (rectangle TANK_TOP_WIDTH TANK_HEIGHT "solid" "black")
              (rectangle TANK_WIDTH (/ TANK_HEIGHT  2) "solid" "black")))
(define TANK_SPEED 3)

(define GAME_OVER (text "Game OVER!" 12 "black"))
(define YOU_WIN (text "You Win!" 12 "green"))
(define YOU_LOSE (text "You Lose!" 12 "red"))

; MissileOrNot Image -> Image 
; adds an image of missile m to scene s
(check-expect (missile-render.v2 #false BACKGROUND) BACKGROUND)
(check-expect (missile-render.v2 (make-posn 32 (- BACKGROUND_HEIGHT TANK_HEIGHT)) BACKGROUND)
  (place-image
   MISSILE
   (posn-x (make-posn 32 (- BACKGROUND_HEIGHT TANK_HEIGHT)))
   (posn-y (make-posn 32 (- BACKGROUND_HEIGHT TANK_HEIGHT)))
   BACKGROUND)) 
(define (missile-render.v2 m s)
  (cond
    [(not (false? m)) (place-image MISSILE (posn-x m) (posn-y m) s)]
    [else s]))



